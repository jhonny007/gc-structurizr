        gcWeb = container "gc-web" "" "" "Website"
        gcApi = container "gc-api"
        gcDb  = container "gc-db" "" "" "Database"

        user -> gcWeb "Uses"

        gcWeb -> gcApi "Uses"
        gcApi -> gcDb  "Access"

        gcWeb -> gravatarApi "Uses API"
        gcApi -> gravatarApi "Uses API"



