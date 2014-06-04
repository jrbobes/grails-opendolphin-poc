modules = {
  application {
    resource url: 'js/application.js'
  }

  require {
    resource url: 'js/require.js'
  }

  openDolphing {
    resource url: 'js/opendolphin.js'
    dependsOn 'require'
  }
}