#https://testdriven.io/blog/developing-a-single-page-app-with-flask-and-vuejs/
FROM python:3.9 AS capstone_webapp
RUN mkdir flask-vue-crud
RUN cd flask-vue-crud

#RUN apt-get install python3-venv
RUN python -m venv env
RUN . env/bin/activate
RUN pip install Flask==1.1.2 Flask-Cors==3.0.10

#RUN npm install -g npm
#RUN npm install -g @vue/cli@4.5.11

#vue create client

#RUN npm install axios@0.21.1 --save
#RUN npm install bootstrap@4.6.0 --save