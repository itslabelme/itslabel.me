# README


## Install wkhtmltopdf on server

wkhtmltopdf is used for generating pdfs.
We have the export to PDF functionality on Free Text Translation Widget and Template Translation Widget.

$ sudo apt install wkhtmltopdf




## Edit Credentials.yml.enc & master.key

type the below command from the terminal to edit the credentials

```
$ EDITOR=vim rails credentials:edit
```

Read the following for more information about why and how rails uses config/credentials.yml.enc and config/master.key

1) https://www.viget.com/articles/storing-secret-credentials-in-rails-5-2-and-up/
2) https://blog.engineyard.com/rails-encrypted-credentials-on-rails-5.2

Note: master.key should be in config/ folder and is not checked into git. This is made as a linked file while deploying using capistrano just like database.yml 

This is how you access the values from the rails app

>>> Rails.application.credentials.development[:facebook][:app_id]

## Testing Facebook and Google Login in local

You need to set the ENV variable ITS_PORT to get the facebook redirection working 
```
$ export ITS_PORT=3001
$ echo $ITS_PORT
3001
```


