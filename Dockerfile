FROM tensorflow/serving

ENV MODEL_BASE_PATH /models
ENV MODEL_NAME models
ENV MODEL_CONFIG_FILE model_config.config

COPY models/age_model /models/age_model
COPY models/ethnicity_model /models/ethnicity_model
COPY models/gender_model /models/gender_model
COPY models/model_config.config /models/model_config.config

# docker run -p 8038:8501 --mount type=bind,source="$(pwd)\models\age_model",target=/models/age_model 
# --mount type=bind,source="$(pwd)\models\ethnicity_model",target=/models/ethnicity_model 
# --mount type=bind,source="$(pwd)\models\gender_model",target=/models/gender_model 
# --mount type=bind,source="$(pwd)\models\model_config.config",target=/models/model_config.config -t tensorflow/serving 
# --model_config_file=/models/model_config.config

# docker build -t judaspriest999/tf-serving-heroku . 
# docker run -p 8501:8501 -e PORT=8501 -t judaspriest999/tf-serving-heroku
# docker tag <image> registry.heroku.com/<app>/<process-type>
# docker push registry.heroku.com/<app>/<process-type>

# deploy:
# heroku container:login
# heroku create ${YOUR_APP_NAME}
# heroku container:push web -a ${YOUR_APP_NAME}
# heroku container:release web -a ${YOUR_APP_NAME}


# Fix because base tf_serving_entrypoint.sh does not take $PORT env variable while $PORT is set by Heroku
# CMD is required to run on Heroku
COPY tf_serving_entrypoint.sh /usr/bin/tf_serving_entrypoint.sh
RUN chmod +x /usr/bin/tf_serving_entrypoint.sh
ENTRYPOINT []
CMD ["/usr/bin/tf_serving_entrypoint.sh"]