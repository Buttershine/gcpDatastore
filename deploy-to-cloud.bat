rem Transpile code to Node 6 (needed for Cloud Functions)
rem rmdir /s/q dist\
rem npx babel index.js src\*.js --presets es2015,stage-3 --out-dir dist\ --ignore *.test.js

rem Setup dist folder with additional files
rem echo DATASTORE_NAMESPACE=example-app-188303-`date +%s` > dist/.env
copy package.json dist

rem Deploy to Cloud Functions
rem GCLOUD_BIN="${GCLOUD_BIN:-gcloud}"
gcloud beta functions deploy api --source=dist\ --trigger-http
gcloud beta functions describe api --format=text | grep 'httpsTrigger.url:' | grep -o 'https://.*'
rem echo API_URL=$API_URL
rem sleep 5

rem Smoke test API endpoint
rem curl --silent $API_URL/ping
rem echo

rem Run Postman tests against local deployed API
rem echo "Using newman runner located at: ["`which newman`"]"
rem newman run --global-var="apiUrl=$API_URL" ./api-tests.postman.json
