Config = {}

Config.Core = 'qb-core' -- Resource name of the core resource
Config.Target = 'qb-target' -- Resource name of the target resource
Config.Notify = 'qb' -- ox / qb

Config.Dispatch = {
	Enable = false, -- Enable or Disable the dispatch system
	Resource = 'ps-dispatch' -- Resource name of the dispatch system
}

Config.SexPrice = 5000 -- Price
Config.BlowJobPrice = 2000 -- Price

Config.PimpGuy = { -- Pimp guy locations
	{
		model = 's_m_m_bouncer_01',
	    coords = vector4(499.66, -651.90, 24.91, 260.47)
	},
	{
		model = 's_m_m_bouncer_01',
	    coords = vector4(973.29, -192.18, 73.20, 240.46)
	}
}

Config.Hookerspawns = { -- Hooker spawn locations
	vector4(223.86, 291.94, 104.54, 247.67),
	vector4(-419.02, 253.65, 82.21, 173.97),
	vector4(-588.05, 272.25, 81.4, 171.54),
	vector4(-575.04, 246.76, 81.88, 350.31),
	vector4(-1392.72, -583.99, 29.25, 27.13),
	vector4(-1404.44, -563.37, 29.27, 210.09),
	vector4(-1097.55, -1959.07, 12.0, 248.76),
	vector4(-887.86, -2184.41, 7.63, 132.86),
	vector4(-40.43, -1724.76, 28.3, 20.36),
	vector4(1131.76, -766.04, 56.76, 359.89),
	vector4(952.16, -141.97, 73.49, 148.05),
	vector4(258.53, -834.11, 28.56, 157.76)
}