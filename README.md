#README

Descarga tu proyecto e instala dependencias con
`bundle install`

Los archivos de configuración que necesitan adecuar para este proyecto se encuentran en las siguientes ubicaciones.

Para MongoDB lo encontrarás en:

`config/mongoid.yml`

Para Redis lo encontrarás en:

`config/initializers.rb`

Para poner a prueba la API debes poseer un token de acceso que puedes generar de la siguiente manera. Dentro de la carpeta de proyecto

Iniciaremos la consola de rails
`rails c`
Construiremos un nuevo objeto vacío
 `cm = CommercialEntity.new`
 Le pondremos un nombre al atributo
 
 `cm.name = "Some name"`
 Al final salvaremos
 `cm.save`

 Esto último generará el auth_token que utilizarás para hacer peticiones. Se puede consultar mediante su atributo `CommercialEntity.last.auth_token`
 y debe sustituirlo la cabecera _Authorization_ para obtener acceso a la API.


 Si quieres iniciar un ciclo de pruebas completo solo debes hacer un
 `bundle exec rspec`

 ## Nota! 
 Las pruebas que utilicen un token de acceso fracasaran si no actualizamos el token de acceso descrito en
 `let(:auth_token) {
   'Token token="d8ee89dddcf84dc28a6bcb7e0aa3341c"'
 }``

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

Un JSON de respuesta puede ser el siguiente:
Este es un token de tarjeta de crédito
`{"token":"9250fc58ba8c4d0a9b6faed34e1cb7ad"}`

Lo cual nos devuelve un Token (que mantiene relación con los datos que acabamos de enviar. Esos datos están cifrados en Redis en estos momentos)


Puedes intentar accederlos entrando a la consola de rails y haciendo un 
`rails c`
`$redis.get(cd1f7a9f09294c95a09e59c144b9c369)`

Para ver los datos descifrados necesitas algo como

`TextCipherHelper.decrypt($redis.get('cd1f7a9f09294c95a09e59c144b9c369'))`

El token devuelto debe ser sustituido en el _body_ de nuestra aplicación para completar el flujo

`curl -X "POST" "http://localhost:3000/transaction/new" \
     -H "Authorization: Token token=9250fc58ba8c4d0a9b6faed34e1cb7ad" \
     -H "Content-Type: application/json" \
     -d "{\"token\":\"9f4d85897ac54ad682d8ef667bcd9655\",\"amount\":\"\\\"1200\\\"\"}"`
     
     
Por cierto las siguientes tarjetas de crédito están en lista negra

4555173000000121", "4098513001237467", "345678000000007


