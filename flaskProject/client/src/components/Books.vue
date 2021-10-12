<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h1>Sessions</h1>
        <hr> <br><br>
        <button type="button" class="btn btn-success btn-sm">Add Session</button>
        <br><br>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">sessionID</th>
              <th scope="col">brain</th>
              <th scope="col">time</th>
              <th scope="col">startingFitness</th>
              <th scope="col">endingFitness</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(book, index) in books" :key="index">
              <td>{{ book[0] }}</td>
              <td>{{ book[1] }}</td>
              <td>{{ book[2] }}</td>
              <td>{{ book[3] }}</td>
              <td>{{ book[4] }}</td>
<!--              <td>-->
<!--                <span v-if="book.read">Yes</span>-->
<!--                <span v-else>No</span>-->
<!--              </td>-->
              <td>
                <div class="btn-group" role="group">
                  <button type="button" class="btn btn-warning btn-sm">Update</button>
                  <button type="button" class="btn btn-danger btn-sm">Delete</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      books: [],
    };
  },
  methods: {
    getBooks() {
      console.log(this.books);
      const path = 'http://localhost:5000/sessions';
      axios.get(path)
        .then((res) => {
          this.books = res.data.books;
          this.books = res.data;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
  },
  created() {
    this.getBooks();
  },
};

</script>
