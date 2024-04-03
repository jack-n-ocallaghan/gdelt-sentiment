### GDELT API Access Script: Awareness and Sentiment Analysis
library(dplyr)
library(tidyr)

places <- c("Aberdeen", "Aberystwyth", "Alness+and+Invergordon", "Andover",
"Arbroath+and+Montrose", "Ashford", "Aviemore", "Ayr", "Ballymena", "Banbury",
"Bangor+and+Holyhead", "Barnsley", # 12
"Barnstaple", "Furness", "Basingstoke", "Bath", "Bedford",
"Belfast", "Berwick", "Bideford", "Birkenhead", "Birmingham", #22
"Blackburn", "Blackpool", "Gillingham",
"Blyth+and+Ashington", "Boston", "Bournemouth", "Bradford",
"Brecon", "Bridgend", "Bridgwater", "Bridlington", "Bridport", #34
"Brighton", "Bristol", "Broadford", "Bude", #38
"Burnley", "Burton", "Suffolk", "Buxton", #42
"Cambridge", "Campbeltown", "Canterbury", "Cardiff", "Cardigan",
"Carlisle", "Chelmsford", "Cheltenham", "Chester", "Chesterfield", #52
"Chichester+and+Bognor+Regis", "Cinderford",
"Clacton", "Colchester", "Coleraine", "Colwyn+Bay", #58
"Cookstown+and+Magherafelt", "Corby", "Coventry", "Craigavon", #62
"Crawley", "Crewe", "Cromer+and+Sheringham",
"Dalbeattie+and+Castle+Douglas", "Darlington", "Derby", "Derry",
"Doncaster", "Dorchester+and+Weymouth", "Dudley", #72
"Dumbarton+and+Helensburgh", "Dumfries", "Dundee",
"Dunfermline+and+Kirkcaldy", "Dungannon", "Dunoon+and+Rothesay", #78
"Durham+and+Bishop+Auckland", "Eastbourne", "Edinburgh", "Elgin",
"Enniskillen", "Evesham", "Exeter", "Falkirk+and+Stirling", #86
"Falmouth", "Folkestone+and+Dover", "Glencoe",
"Fraserburgh",
"Galashiels+and+Peebles", "Girvan", "Glasgow", "Gloucester", #94
"Golspie+and+Brora", "Grantham", "Great+Yarmouth", "Greenock",
"Grimsby", "Guildford+and+Aldershot", "Halifax", "Harrogate", #102
"Hartlepool", "Hastings", "Haverfordwest+and+Milford+Haven",
"Hawick+and+Kelso", "Hereford", "Hexham", #108
"High+Wycombe+and+Aylesbury", "Huddersfield", "Hull", "Huntingdon",
"Inverness", "Ipswich", "Wight", "Kendal", #116 # ??
"Kettering+and+Wellingborough", "Kilmarnock+and+Irvine",
"King's+Lynn", "Kingsbridge+and+Dartmouth",
"Lancaster+and+Morecambe", "Launceston", "Leamington+Spa", "Leeds", #124
"Leicester", "Lincoln", "Liskeard", "Liverpool", "Livingston",
"Llandrindod+Wells+and+Builth+Wells", "Llanelli", "Lochgilphead", #132
"London", "Lowestoft", "Ludlow", "Luton", "Malton", "Manchester", #138
"Mansfield", "Margate+and+Ramsgate", "Medway", "Merthyr+Tydfil", #142
"Middlesbrough+and+Stockton", "Milton+Keynes", "Minehead",
"Motherwell+and+Airdrie", "Mull+and+Islay", "Newbury", "Newcastle",
"Newport", "Newry+and+Banbridge", "Newton+Stewart", #152
"Newtown+and+Welshpool", "Northallerton", "Northampton", "Norwich",
"Nottingham", "Oban", "Omagh+and+Strabane", "Orkney+Islands", #160
"Oswestry", "Oxford", "Pembroke+and+Tenby", "Penrith", "Penzance",
"Perth", "Peterborough", "Peterhead", "Pitlochry",
"Plymouth", "Poole", "Portree", "Portsmouth", "Preston", #174
"Pwllheli+and+Porthmadog", "Reading", "Redruth+and+Truro", "Rhyl", #178
"Salisbury", "Scarborough", "Scunthorpe", "Sheffield", #182
"Shetland+Islands", "Shrewsbury", "Sidmouth", "Skegness+and+Louth", #186
"Skipton", "Slough+and+Heathrow+Airport", "Southampton","Southend", #190
"Spalding", "St+Andrews", "St+Austell+and+Newquay",
"Stafford", "Stevenage+and+Welwyn+Garden+City", "Stoke+on+Trent", #196
"Stranraer", "Street+and+Wells", "Sunderland", "Swansea", "Swindon",
"Taunton", "Telford", "Thetford+and+Mildenhall", "Thurso",
"Torquay+and+Paignton", "Trowbridge", "Tunbridge+Wells",
"Turriff+and+Banff", "Tywyn+and+Dolgellau", "Ullapool",
"Wadebridge", "Wakefield+and+Castleford", "Warrington+and+Wigan",
"Western+Isles", "Weston+super+Mare", "Whitby", "Whitehaven",
"Wick", "Wisbech", "Wolverhampton+and+Walsall",
"Worcester+and+Kidderminster", "Workington", "Worksop+and+Retford",
"Worthing", "Wrexham", "Yeovil", "York")
# Blandford Forum and Gillingham -> Gillingham
# Pitlochry and Aberfaldy -> Pitlochry
# Fort William -> Glencoe
# Aberdeen -> Aberdeen
# Aviemore and Grantown-on-Spey -> Aviemore
# Barrow-In-Furness -> Furness
# Broadford and Kyle-of-Lochalsh -> Broadford
# Burton-upon-Trent -> Burton
# Bury-St-Edmunds -> Suffolk
# Cinderford and Ross-on-Wye -> Cinderford
# Isle-of-Wight -> Wight
# St Andrews and Cupar -> St Andrews
# Dashes cause errors and have been removed

# HHTP 429 is too many requests

## Iterative Data Request
data_frames <- list()

for (i in 1:length(places)) {

  request <- paste0("https://api.gdeltproject.org/api/v2/doc/doc?query=",
                     places[[i]],
                    "&mode=ToneChart&timespan=5y&FORMAT=csv")

  input <- read.csv(request) %>% select(Label, Count) %>% mutate(Place = places[[i]])
  input <- as.data.frame(input)
  
  data_frames[[i]] <- input
  
}

rm(input)

## Data Manipulation
test <- data %>% pivot_wider(data$Query)
