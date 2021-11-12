<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h1>Brains</h1>
        <hr> <br><br>
        <alert :message=message v-if="showMessage"></alert>

        <button type="button" class="btn btn-success btn-sm" v-b-modal.book-modal>
          Add Brain</button>
        <br><br>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">brain</th>
              <th scope="col">fitness</th>
              <th scope="col">birthdate</th>
              <th scope="col">sessions</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(book, index) in brains" :key="index">
              <td>{{ book[0] }}</td>
              <td>{{ book[1] }}</td>
              <td>{{ book[2] }}</td>
              <td>{{ book[3] }}</td>
<!--              <td>-->
<!--                <span v-if="book.read">Yes</span>-->
<!--                <span v-else>No</span>-->
<!--              </td>-->
              <td>
                <div class="btn-group" role="group">
                  <button type="button"
                          class="btn btn-warning btn-sm"
                          v-b-modal.book-modal
                          @click="onUpdateBook(book)">Update</button>
                  <button
                    type="button"
                    class="btn btn-danger btn-sm"
                    @click="onDeleteBook(book)">
                    Delete
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <!-- Modal Component -->
    <b-modal ref="addBookModal"
            id="book-modal"
            title="Add a Brain"
            hide-footer>
      <b-form @submit="onSubmit" @reset="onReset" class="w-100">
      <b-form-group id="form-brain-group"
                    label="Brain:"
                    label-for="form-title-input">
          <b-form-input id="form-brain-input"
                        type="text"
                        v-model="addSessionForm.brain"
                        required
                        placeholder="Enter Brain">
          </b-form-input>
        </b-form-group>
        <b-form-group id="form-time-group"
                      label="Time:"
                      label-for="form-time-input">
            <b-form-input id="form-time-input"
                          type="number"
                          v-model="addSessionForm.time"
                          required
                          placeholder="Enter Time">
            </b-form-input>
          </b-form-group>
        <b-form-group id="form-fitness-group"
                      label="Fitness:"
                      label-for="form-startingFitness-input">
            <b-form-input id="form-startingFitness-input"
                          type="number"
                          v-model="addSessionForm.startingFitness"
                          required
                          placeholder="Enter Starting Fitness">
            </b-form-input>
                      <b-form-input id="form-endingFitness-input"
                          type="number"
                          v-model="addSessionForm.endingFitness"
                          required
                          placeholder="Enter Ending Fitness">
            </b-form-input>
          </b-form-group>
        <b-form-group id="form-read-group">
          <b-form-checkbox-group v-model="addSessionForm.read" id="form-checks">
            <b-form-checkbox value="true">Read?</b-form-checkbox>
          </b-form-checkbox-group>
        </b-form-group>
        <b-button-group>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Reset</b-button>
        </b-button-group>
      </b-form>
    </b-modal>
  </div>
</template>

<script>
import axios from 'axios';
import Alert from './Alert.vue';

export default {
  data() {
    return {
      brains: [],
      addSessionForm: {
        brain: '',
        time: '',
        startingFitness: '',
        endingFitness: '',
        read: [],
        formIsUpdateMode: false,
      },
      message: '',
      showMessage: false,
    };
  },
  components: {
    alert: Alert,
  },
  methods: {
    getBrains() {
      const path = 'http://localhost:5000/brains';
      axios.get(path)
        .then((res) => {
          this.brains = res.data;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
    addBook(payload) {
      const path = 'http://localhost:5000/brains';
      axios.post(path, payload)
        .then(() => {
          this.getBrains();
          this.message = 'Brains added!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.log(error);
          this.getBrains();
        });
    },
    updateBook(sessionID, payload) {
      const path = `http://localhost:5000/brains/${sessionID}`;
      axios.put(path, payload)
        .then(() => {
          this.getBrains();
          this.message = 'Brain Updated!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.log(error);
          this.getBrains();
        });
    },
    initForm() {
      this.addSessionForm.brain = '';
      this.addSessionForm.time = '';
      this.addSessionForm.startingFitness = '';
      this.addSessionForm.endingFitness = '';
      this.addSessionForm.read = [];
      this.addSessionForm.formIsUpdateMode = -1;
    },
    onSubmit(evt) {
      evt.preventDefault();
      this.$refs.addBookModal.hide();
      let read = false;
      if (this.addSessionForm.read[0]) read = true;
      const payload = {
        brain: `'${this.addSessionForm.brain}'`,
        time: this.addSessionForm.time,
        startingFitness: this.addSessionForm.startingFitness,
        endingFitness: this.addSessionForm.endingFitness,
        read, // property shorthand
      };
      if (this.addSessionForm.formIsUpdateMode >= 0) {
        this.updateBook(this.addSessionForm.formIsUpdateMode, payload);
      } else {
        this.addBook(payload);
      }
      this.initForm();
    },
    onReset(evt) {
      evt.preventDefault();
      this.$refs.addBookModal.hide();
      this.initForm();
    },
    removeBook(book) {
      const sessionID = book[0];
      const path = `http://localhost:5000/brains/${sessionID}`;
      axios.delete(path)
        .then(() => {
          this.getBrains();
          this.message = 'Brain Deleted!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
      console.error("ERR "+error);
          this.getBrains();
        });
    },
    onDeleteBook(book) {
      this.removeBook(book);
    },
    onUpdateBook(book) {
      // eslint-disable-next-line prefer-destructuring
      this.addSessionForm.formIsUpdateMode = book[0];
      // eslint-disable-next-line prefer-destructuring
      this.addSessionForm.brain = book[1];
      // eslint-disable-next-line prefer-destructuring
      this.addSessionForm.time = book[2];
      // eslint-disable-next-line prefer-destructuring
      this.addSessionForm.startingFitness = book[3];
      // eslint-disable-next-line prefer-destructuring
      this.addSessionForm.endingFitness = book[4];
      this.updateBook(book);
    },
  },
  created() {
    this.getBrains();
    console.log(this.brains);
  },
};
</script>
