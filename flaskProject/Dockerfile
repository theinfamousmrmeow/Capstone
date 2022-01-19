#https://testdriven.io/blog/developing-a-single-page-app-with-flask-and-vuejs/
FROM python:3.9 AS capstone_webapp
EXPOSE 5000
EXPOSE 8080

ENV MYSQL_IP='143.198.133.105'
ENV MYSQL_PORT='49155'
ENV MYSQL_UN="remoteadmin"
ENV MYSQL_PW="password"

ENV VUE_APP_WEBAPP_IP='http://localhost:49155'

RUN mkdir webapp
RUN cd webapp
WORKDIR /webapp/

RUN apt-get -y update
RUN apt-get -y upgrade
RUN pip install --upgrade pip
RUN apt-get -y install software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash
RUN apt-get -y install nodejs

ADD requirements.txt .

RUN python -m pip install -r requirements.txt

COPY client client
COPY app.py .

#RUN npm install -g npm
#RUN npm install npm
RUN npm install -g @vue/cli@4.5.11
RUN npm install -g apexcharts

#RUN vue create client

RUN npm install axios@0.21.1 --save
RUN npm install bootstrap@4.6.0 --save

#RUN apt-get install python3-venv
RUN python -m venv env
RUN . env/bin/activate
RUN pip install Flask==1.1.2 Flask-Cors==3.0.10
#CMD cd client && npm run serve ; python3 app.py

COPY start_backend.sh start_backend.sh
COPY start_frontend.sh start_frontend.sh
COPY wrapperscript.sh wrapperscript.sh

RUN chmod 777 ./wrapperscript.sh
RUN chmod 777 ./start_frontend.sh
RUN chmod 777 ./start_backend.sh
RUN chmod -R 777 client
#RUN chmod -R 777 Scripts

CMD ./wrapperscript.sh

#RUN python3 app.py
#RUN cd client
#RUN npm run serve