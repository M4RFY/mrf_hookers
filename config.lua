Config = {}

Config.Debug = false
Config.Core = 'qb-core'
Config.Target = 'qb-target'
Config.Notify = "ox" -- ox / qb / okok

Config.Dispatch = {
	Enable = false,
	Resource = 'ps-dispatch'
}

Config.BlowjobPrice	= 500 -- Change price for blowjob here
Config.SexPrice	= 1000 -- Change price for sex here

Config.DrawDistance = 3.0
Config.DrawMarker = 10.0

Config.PimpGuy = {
	{ model = "s_m_m_bouncer_01", coords = vec4(490.69, -1085.69, 27.94, 312.84) }
}

Config.Zones = {
	["Pimp"] = { Pos = vec4(490.69, -1085.69, 28.94, 312.84) },
}

Config.Hookerspawns = {
	[1] = vec4(223.86, 291.94, 104.54, 247.67),
	[2] = vec4(-419.02, 253.65, 82.21, 173.97),
	[3] = vec4(-588.05, 272.25, 81.4, 171.54),
	[4] = vec4(-575.04, 246.76, 81.88, 350.31),
	[5] = vec4(-1392.72, -583.99, 29.25, 27.13),
	[6] = vec4(-1404.44, -563.37, 29.27, 210.09),
	[7] = vec4(-1097.55, -1959.07, 12.0, 248.76),
	[8] = vec4(-887.86, -2184.41, 7.63, 132.86),
	[9] = vec4(-40.43, -1724.76, 28.3, 20.36),
	[10] = vec4(1131.76, -766.04, 56.76, 359.89),
	[11] = vec4(952.16, -141.97, 73.49, 148.05),
	[12] = vec4(258.53, -834.11, 28.56, 157.76),
}