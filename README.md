#README

Descarga tu proyecto e instala dependencias con
`bundle install`

Los archivos de configuración que necesitan adecuar para este proyecto se encuentran en las siguientes ubicaciones.

Para MongoDB lo encontrarás en:

`config/mongoid.yml`

Para Redis lo encontrarás en:

`config/initializers.rb`

Para poner a prueba la API debes poseer un token de acceso que puedes generar de la siguiente manera. Dentro de la carpeta de proyecto

`rails c
 cm = CommercialEntity.new
 cm.name = "Some name"
 cm.save`

 Esto último generará el token de acceso que utilizarás para hacer peticiones. Se puede consultar mediante su atributo `auth_token`

 Si quieres iniciar un ciclo de pruebas completo solo debes hacer un
 `bundle exec rspec`

#Request

`curl -X "POST" "http://localhost:3000/token_processor/new" \
     -H "Authorization: Token token=d8ee89dddcf84dc28a6bcb7e0aa3341c" \
     -H "Content-Type: application/json" \
     -d $'{
"credit_card_number": "4152314005194769",
"name": "Fernando Ruiz",
"expiry_date": "12/17",
"cvc": "123"
}'
`

Lo cual nos devuelve un Token (que mantiene relación con los datos que acabamos de enviar. Esos datos están cifrados en Redis en estos momentos)

Un JSON de respuesta puede ser el siguiente:

`{"token":"9250fc58ba8c4d0a9b6faed34e1cb7ad"}`

Debemos sustituirlo en la cabecera correspondiente para poder acceder a la API
`curl -X "POST" "http://localhost:3000/transaction/new" \
     -H "Authorization: Token token=9250fc58ba8c4d0a9b6faed34e1cb7ad" \
     -H "Content-Type: application/json" \
     -d "{\"token\":\"9f4d85897ac54ad682d8ef667bcd9655\",\"amount\":\"\\\"1200\\\"\"}"`
