class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?" {
      constraints {
        // apply constraints here
      }
    }

    "/"(view: "openDolphing/simpleExample")
//		"/"(view:"/index")


    "500"(view: '/error')

  }
}
