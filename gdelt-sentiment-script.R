### --- GDELT API Access Script: Awareness and Sentiment Analysis --- ----------
library(dplyr)
library(tidyr)

## -- Place Names -- -----------------------------------------------------------
places <- c("Aberdeen",
            "Aberystwyth",
            "Alness+and+Invergordon",
            "Andover",
            "Arbroath+and+Montrose",
            "Ashford",
            "Aviemore+and+Grantown+on+Spey",
            "Ayr",
            "Banbury",
            "Bangor+and+Holyhead",
            "Barnsley",
            "Barnstaple",
            "Barrow+in+Furness",
            "Basingstoke",
            "Bath",
            "Bedford",
            "Berwick",
            "Bideford",
            "Birkenhead",
            "Birmingham",
            "Blackburn",
            "Blackpool",
            "Blandford+Forum+and+Gillingham",
            "Blyth+and+Ashington",
            "Boston",
            "Bournemouth",
            "Bradford",
            "Brecon",
            "Bridgend",
            "Bridgwater",
            "Bridlington",
            "Bridport",
            "Brighton",
            "Bristol",
            "Broadford+and+Kyle+of+Lochalsh",
            "Bude",
            "Burnley",
            "Burton+upon+Trent",
            "Bury+St+Edmunds",
            "Buxton",
            "Cambridge",
            "Campbeltown",
            "Canterbury",
            "Cardiff",
            "Cardigan",
            "Carlisle",
            "Chelmsford",
            "Cheltenham",
            "Chester",
            "Chesterfield",
            "Chichester+and+Bognor+Regis",
            "Cinderford+and+Ross+on+Wye",
            "Clacton",
            "Colchester",
            "Colwyn+Bay",
            "Corby",
            "Coventry",
            "Crawley",
            "Crewe",
            "Cromer+and+Sheringham",
            "Dalbeattie+and+Castle+Douglas",
            "Darlington",
            "Derby",
            "Doncaster",
            "Dorchester+and+Weymouth",
            "Dudley",
            "Dumbarton+and+Helensburgh",
            "Dumfries",
            "Dundee",
            "Dunfermline+and+Kirkcaldy",
            "Dunoon+and+Rothesay",
            "Durham+and+Bishop+Auckland",
            "Eastbourne",
            "Edinburgh",
            "Elgin",
            "Evesham",
            "Exeter",
            "Falkirk+and+Stirling",
            "Falmouth",
            "Folkestone+and+Dover",
            "Fort+William",
            "Fraserburgh",
            "Galashiels+and+Peebles",
            "Girvan",
            "Glasgow",
            "Gloucester",
            "Golspie+and+Brora",
            "Grantham",
            "Great+Yarmouth",
            "Greenock",
            "Grimsby",
            "Guildford+and+Aldershot",
            "Halifax",
            "Harrogate",
            "Hartlepool",
            "Hastings",
            "Haverfordwest+and+Milford+Haven",
            "Hawick+and+Kelso",
            "Hereford",
            "Hexham",
            "High+Wycombe+and+Aylesbury",
            "Huddersfield",
            "Hull",
            "Huntingdon",
            "Inverness",
            "Ipswich",
            "Isle+of+Wight",
            "Kendal",
            "Kettering+and+Wellingborough",
            "Kilmarnock+and+Irvine",
            "King's+Lynn",
            "Kingsbridge+and+Dartmouth",
            "Lancaster+and+Morecambe",
            "Launceston",
            "Leamington+Spa",
            "Leeds",
            "Leicester",
            "Lincoln",
            "Liskeard",
            "Liverpool",
            "Livingston",
            "Llandrindod+Wells+and+Builth+Wells",
            "Llanelli",
            "Lochgilphead",
            "London",
            "Lowestoft",
            "Ludlow",
            "Luton",
            "Malton",
            "Manchester",
            "Mansfield",
            "Margate+and+Ramsgate",
            "Medway",
            "Merthyr+Tydfil",
            "Middlesbrough+and+Stockton",
            "Milton+Keynes",
            "Minehead",
            "Motherwell+and+Airdrie",
            "Mull+and+Islay",
            "Newbury",
            "Newcastle",
            "Newport",
            "Newton+Stewart",
            "Newtown+and+Welshpool",
            "Northallerton",
            "Northampton",
            "Norwich",
            "Nottingham",
            "Oban",
            "Orkney+Islands",
            "Oswestry",
            "Oxford",
            "Pembroke+and+Tenby",
            "Penrith",
            "Penzance",
            "Perth",
            "Peterborough",
            "Peterhead",
            "Pitlochry+and+Aberfeldy",
            "Plymouth",
            "Poole",
            "Portree",
            "Portsmouth",
            "Preston",
            "Pwllheli+and+Porthmadog",
            "Reading",
            "Redruth+and+Truro",
            "Rhyl",
            "Salisbury",
            "Scarborough",
            "Scunthorpe",
            "Sheffield",
            "Shetland+Islands",
            "Shrewsbury",
            "Sidmouth",
            "Skegness+and+Louth",
            "Skipton",
            "Slough+and+Heathrow",
            "Southampton",
            "Southend",
            "Spalding",
            "St+Andrews+and+Cupar",
            "St+Austell+and+Newquay",
            "Stafford",
            "Stevenage+and+Welwyn+Garden+City",
            "Stoke+on+Trent",
            "Stranraer",
            "Street+and+Wells",
            "Sunderland",
            "Swansea",
            "Swindon",
            "Taunton",
            "Telford",
            "Thetford+and+Mildenhall",
            "Thurso",
            "Torquay+and+Paignton",
            "Trowbridge",
            "Tunbridge+Wells",
            "Turriff+and+Banff",
            "Tywyn+and+Dolgellau",
            "Ullapool",
            "Wadebridge",
            "Wakefield+and+Castleford",
            "Warrington+and+Wigan",
            "Western+Isles",
            "Weston+super+Mare",
            "Whitby",
            "Whitehaven",
            "Wick",
            "Wisbech",
            "Wolverhampton+and+Walsall",
            "Worcester+and+Kidderminster",
            "Workington",
            "Worksop+and+Retford",
            "Worthing",
            "Wrexham",
            "Yeovil",
            "York",
            "Ballymena",
            "Belfast",
            "Cookstown+and+Magherafelt",
            "Craigavon",
            "Dungannon",
            "Newry+and+Banbridge",
            "Coleraine",
            "Derry",
            "Omagh+and+Strabane",
            "Enniskillen")

# HHTP 429 is too many requests

## -- Iterative Data Request -- ------------------------------------------------
data_frames <- list()

for (i in 1:length(places)) {
  tryCatch({
    
    #request <- paste0("https://api.gdeltproject.org/api/v2/doc/doc?query=",
    #                  places[[i]], "&mode=ToneChart&timespan=5y&FORMAT=csv")
    
    request <- paste0("https://api.gdeltproject.org/api/v2/doc/doc?query=",
                      places[[i]], "&sourcecountry=UK&contentmode=ToneChart&timespan=5y&FORMAT=csv")
    
    # mode vs. contentmode ???
    
    data_frames[[i]] <- read.csv(request, stringsAsFactors = FALSE) %>%
      mutate(Place = places[[i]]) %>% as.data.frame()
    
  }, error = function(e) {
    
    message(paste("Failed to read CSV")) # Error message
    # data_frames[[i]] <- data.frame(A = 0, B = 0, Place = places[[i]])
    
  })
}

#test <- read.csv(
#  "https://api.gdeltproject.org/api/v2/doc/doc?query=Test&mode=ToneChart&timespan=5y&FORMAT=csv")
# If this doesn't work, you probably have an issue in accessing the API

# Error 429 is too many API requests

## -- Some Other Shenanigans -- ------------------------------------------------
data_frames[[23]] <- data.frame(Label = 0, Count = 0, Place = places[23]) # Odd NULL Case

data_frames[[7  ]] <- data.frame(Label = 0, Count = 0, Place = places[7  ])
data_frames[[13 ]] <- data.frame(Label = 0, Count = 0, Place = places[13 ])
data_frames[[35 ]] <- data.frame(Label = 0, Count = 0, Place = places[35 ])
data_frames[[39 ]] <- data.frame(Label = 0, Count = 0, Place = places[39 ])
data_frames[[52 ]] <- data.frame(Label = 0, Count = 0, Place = places[52 ])
data_frames[[107]] <- data.frame(Label = 0, Count = 0, Place = places[107])
data_frames[[182]] <- data.frame(Label = 0, Count = 0, Place = places[182])
data_frames[[183]] <- data.frame(Label = 0, Count = 0, Place = places[183])
data_frames[[186]] <- data.frame(Label = 0, Count = 0, Place = places[186])# Error Cases

data_frames <- lapply(data_frames, '[', c("Label", "Count", "Place")) # Select Three Cols Only

data_frames <- do.call(rbind, data_frames) # rbind Into a Single df

data_frames <- data_frames %>% group_by(Place) %>%
  mutate(Sentiment = stats::weighted.mean(Label, Count)) %>%
  mutate(Awareness = sum(Count)) %>%
  select(-Label, -Count) %>%
  distinct()

write.csv(data_frames, "ttwa-sentiment-awareness.csv")
