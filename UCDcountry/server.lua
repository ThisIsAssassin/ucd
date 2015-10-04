function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in pairs(Element.getAllByType("player")) do
            local name_ = player:getName():gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

local countryName =
{
	A1 = "Anonymous Proxy",
	A2 = "Satellite Provider",
	O1 = "Other Country",
	AD = "Andorra",
	AE = "United Arab Emirates",
	AF = "Afghanistan",
	AG = "Antigua and Barbuda",
	AI = "Anguilla",
	AL = "Albania",
	AM = "Armenia",
	AO = "Angola",
	AP = "Asia/Pacific Region",
	AQ = "Antarctica",
	AR = "Argentina",
	AS = "American Samoa",
	AT = "Austria",
	AU = "Australia",
	AW = "Aruba",
	AX = "Aland Islands",
	AZ = "Azerbaijan",
	BA = "Bosnia and Herzegovina",
	BB = "Barbados",
	BD = "Bangladesh",
	BE = "Belgium",
	BF = "Burkina Faso",
	BG = "Bulgaria",
	BH = "Bahrain",
	BI = "Burundi",
	BJ = "Benin",
	BL = "Saint Bartelemey",
	BM = "Bermuda",
	BN = "Brunei Darussalam",
	BO = "Bolivia",
	BQ = "Bonaire, Saint Eustatius and Saba",
	BR = "Brazil",
	BS = "Bahamas",
	BT = "Bhutan",
	BV = "Bouvet Island",
	BW = "Botswana",
	BY = "Belarus",
	BZ = "Belize",
	CA = "Canada",
	CC = "Cocos (Keeling) Islands",
	CD = "Congo, The Democratic Republic of the",
	CF = "Central African Republic",
	CG = "Congo",
	CH = "Switzerland",
	CI = "Cote d'Ivoire",
	CK = "Cook Islands",
	CL = "Chile",
	CM = "Cameroon",
	CN = "China",
	CO = "Colombia",
	CR = "Costa Rica",
	CU = "Cuba",
	CV = "Cape Verde",
	CW = "Curacao",
	CX = "Christmas Island",
	CY = "Cyprus",
	CZ = "Czech Republic",
	DE = "Germany",
	DJ = "Djibouti",
	DK = "Denmark",
	DM = "Dominica",
	DO = "Dominican Republic",
	DZ = "Algeria",
	EC = "Ecuador",
	EE = "Estonia",
	EG = "Egypt",
	EH = "Western Sahara",
	ER = "Eritrea",
	ES = "Spain",
	ET = "Ethiopia",
	EU = "Europe",
	FI = "Finland",
	FJ = "Fiji",
	FK = "Falkland Islands (Malvinas)",
	FM = "Micronesia, Federated States of",
	FO = "Faroe Islands",
	FR = "France",
	GA = "Gabon",
	GB = "United Kingdom",
	GD = "Grenada",
	GE = "Georgia",
	GF = "French Guiana",
	GG = "Guernsey",
	GH = "Ghana",
	GI = "Gibraltar",
	GL = "Greenland",
	GM = "Gambia",
	GN = "Guinea",
	GP = "Guadeloupe",
	GQ = "Equatorial Guinea",
	GR = "Greece",
	GS = "South Georgia and the South Sandwich Islands",
	GT = "Guatemala",
	GU = "Guam",
	GW = "Guinea-Bissau",
	GY = "Guyana",
	HK = "Hong Kong",
	HM = "Heard Island and McDonald Islands",
	HN = "Honduras",
	HR = "Croatia",
	HT = "Haiti",
	HU = "Hungary",
	ID = "Indonesia",
	IE = "Ireland",
	IL = "Israel",
	IM = "Isle of Man",
	IN = "India",
	IO = "British Indian Ocean Territory",
	IQ = "Iraq",
	IR = "Iran, Islamic Republic of",
	IS = "Iceland",
	IT = "Italy",
	JE = "Jersey",
	JM = "Jamaica",
	JO = "Jordan",
	JP = "Japan",
	KE = "Kenya",
	KG = "Kyrgyzstan",
	KH = "Cambodia",
	KI = "Kiribati",
	KM = "Comoros",
	KN = "Saint Kitts and Nevis",
	KP = "Korea, Democratic People's Republic of",
	KR = "Korea, Republic of",
	KW = "Kuwait",
	KY = "Cayman Islands",
	KZ = "Kazakhstan",
	LA = "Lao People's Democratic Republic",
	LB = "Lebanon",
	LC = "Saint Lucia",
	LI = "Liechtenstein",
	LK = "Sri Lanka",
	LR = "Liberia",
	LS = "Lesotho",
	LT = "Lithuania",
	LU = "Luxembourg",
	LV = "Latvia",
	LY = "Libyan Arab Jamahiriya",
	MA = "Morocco",
	MC = "Monaco",
	MD = "Moldova, Republic of",
	ME = "Montenegro",
	MF = "Saint Martin",
	MG = "Madagascar",
	MH = "Marshall Islands",
	MK = "Macedonia",
	ML = "Mali",
	MM = "Myanmar",
	MN = "Mongolia",
	MO = "Macao",
	MP = "Northern Mariana Islands",
	MQ = "Martinique",
	MR = "Mauritania",
	MS = "Montserrat",
	MT = "Malta",
	MU = "Mauritius",
	MV = "Maldives",
	MW = "Malawi",
	MX = "Mexico",
	MY = "Malaysia",
	MZ = "Mozambique",
	NA = "Namibia",
	NC = "New Caledonia",
	NE = "Niger",
	NF = "Norfolk Island",
	NG = "Nigeria",
	NI = "Nicaragua",
	NL = "Netherlands",
	NO = "Norway",
	NP = "Nepal",
	NR = "Nauru",
	NU = "Niue",
	NZ = "New Zealand",
	OM = "Oman",
	PA = "Panama",
	PE = "Peru",
	PF = "French Polynesia",
	PG = "Papua New Guinea",
	PH = "Philippines",
	PK = "Pakistan",
	PL = "Poland",
	PM = "Saint Pierre and Miquelon",
	PN = "Pitcairn",
	PR = "Puerto Rico",
	PS = "Palestinian Territory",
	PT = "Portugal",
	PW = "Palau",
	PY = "Paraguay",
	QA = "Qatar",
	RE = "Reunion",
	RO = "Romania",
	RS = "Serbia",
	RU = "Russian Federation",
	RW = "Rwanda",
	SA = "Saudi Arabia",
	SB = "Solomon Islands",
	SC = "Seychelles",
	SD = "Sudan",
	SE = "Sweden",
	SG = "Singapore",
	SH = "Saint Helena",
	SI = "Slovenia",
	SJ = "Svalbard and Jan Mayen",
	SK = "Slovakia",
	SL = "Sierra Leone",
	SM = "San Marino",
	SN = "Senegal",
	SO = "Somalia",
	SR = "Suriname",
	ST = "Sao Tome and Principe",
	SV = "El Salvador",
	SX = "Sint Maarten",
	SY = "Syrian Arab Republic",
	SZ = "Swaziland",
	TC = "Turks and Caicos Islands",
	TD = "Chad",
	TF = "French Southern Territories",
	TG = "Togo",
	TH = "Thailand",
	TJ = "Tajikistan",
	TK = "Tokelau",
	TL = "Timor-Leste",
	TM = "Turkmenistan",
	TN = "Tunisia",
	TO = "Tonga",
	TR = "Turkey",
	TT = "Trinidad and Tobago",
	TV = "Tuvalu",
	TW = "Taiwan",
	TZ = "Tanzania, United Republic of",
	UA = "Ukraine",
	UG = "Uganda",
	UM = "United States Minor Outlying Islands",
	US = "United States",
	UY = "Uruguay",
	UZ = "Uzbekistan",
	VA = "Holy See (Vatican City State)",
	VC = "Saint Vincent and the Grenadines",
	VE = "Venezuela",
	VG = "Virgin Islands, British",
	VI = "Virgin Islands, U.S.",
	VN = "Vietnam",
	VU = "Vanuatu",
	WF = "Wallis and Futuna",
	WS = "Samoa",
	YE = "Yemen",
	YT = "Mayotte",
	ZA = "South Africa",
	ZM = "Zambia",
	ZW = "Zimbabwe"
}

local sqlite_geo_db = dbConnect("sqlite", "GeoIP.db")

local function toIPNum(ip)
	local nums 	= split(ip, 46)
	local ipnum = (nums[1] * 16777216) + (nums[2] * 65536) + (nums[3] * 256) + (nums[4])
	return ipnum
end

function getCountry(ip)
	local num = tostring(toIPNum(ip))
	local res = sqlite_geo_db:query("SELECT `country` FROM `geoIPCountry` WHERE "..num.." BETWEEN begin_num AND end_num LIMIT 1"):poll(-1)
	if res[1] then
		return res[1].country, countryName[res[1].country]
	end
	return false
end

addEventHandler("onPlayerJoin", root,
	function ()
		countryShort, countryLong = getCountry(source:getIP())
		
		if (countryShort) then
			countryShort = countryShort
		elseif (countryShort == false) and (getPlayerFromPartialName("Noki") == source) then
			countryShort = "au"
		else
			countryShort = "unknown"
		end
		
		if (countryLong) then
			countryLong = countryLong
		else
			countryLong = "Unknown"
		end
		
		source:setData("dxscoreboard_loc", ":UCDcountry/flags/"..countryShort..".png", true)
		source:setData("Country", countryLong, true)
	end
)

for _, v in pairs(Element.getAllByType("player")) do
	countryShort, countryLong = getCountry(v:getIP())
	
	if (countryShort) then
		countryShort = countryShort
	elseif (countryShort == false) and (getPlayerFromPartialName("Noki") == v) then
		countryShort = "au"
	else
		countryShort = "unknown"
	end
	
	if (countryLong) then
		countryLong = countryLong
	else
		countryLong = "Unknown"
	end
	
	v:setData("dxscoreboard_loc", ":UCDcountry/flags/"..countryShort..".png", true)
	v:setData("Country", countryLong, true)
end
