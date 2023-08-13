workspace {

    name "Global Currency Trust"
    description "Model and diagrams defining the architecture of the Global Currency System and its interaction with neighboring systems"
           
    model {
        // USERS
        user = person "User"
        developer = person "Developer"

        // SYSTEMS
        githubSoftwareSystem = softwareSystem "Github" "" "Github" {
            gcStructurizrRepo = container "gc-structurizr repo" "" "" "Project"
            gcWebRepo         = container "gc-web repo"         "" "" "Project"
        }
        gravatarSoftwareSystem = softwareSystem "Gravatar" "" "Gravatar" {
            gravatarWeb = container "gravatar-web" "" "" "Website"
            gravatarApi = container "gravatar-api"
        }
        trustSoftwareSystem = softwareSystem "Trust" {
            // Import detailed domain data from subfolder
            !include domains_gc
        }

        // CONNECTIONS
        user -> gravatarWeb "Uses Website"
        developer -> githubSoftwareSystem "Uses"
        
    }

    views {
        systemLandscape overview  "Global Currency" {
            include *
            autoLayout lr
        }

        systemContext trustSoftwareSystem "Trust" {
            include *
            autoLayout lr
        }

        systemContext gravatarSoftwareSystem "Gravatar" {
            include *
            autoLayout lr
        }

        systemContext githubSoftwareSystem "Github" {
            include *
            autoLayout lr
        }

        container trustSoftwareSystem trustContainer "Detail view trust system" {
            include *
            autoLayout lr
        }

        container githubSoftwareSystem githubContainer "Projects on Github" {
            include *
            autoLayout lr
        }

        dynamic trustSoftwareSystem participate {
            title "Participate with an valid Gravatar Profile"
            description "The given e-mail is hashed in the users web browser. Only the hash is used to check for an valid profile. And only the hash is stored in the database."

            user  -> gcWeb "enters email"
            gcWeb -> gravatarApi "checks for profile with hash"
            user  -> gravatarWeb "creates a profile at Gravatar"
            user  -> gcWeb "enters email again"
            gcWeb -> gravatarApi "checks for profile with hash again"
            user  -> gcWeb "wants to participate"
            gcWeb -> gcApi "save participant hash"
            gcApi -> gravatarApi "checks for profile with hash again (same as web-api)"
            gcApi -> gcDb "saves participant hash"

            autoLayout lr
        }



        styles { 
            element "Person" { 
                shape Person
            }
            element "Website" { 
                shape MobileDeviceLandscape
            }
            element "Database" { 
                shape cylinder
            }
            element "Github" { 
                icon "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
            }
            element "Gravatar" { 
                icon "icons/gravatar.png"
            }
        }
    }

}
