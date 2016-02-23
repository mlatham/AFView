import Foundation

extension UIColor
{
	// MARK: - Static Methods
	
	public static func colorWithHex(hex: NSString)
		-> UIColor?
	{
		var result: UIColor? = nil
		
		if (hex.length >= 6)
		{
			var hex: NSString = hex;
		
			if (hex.rangeOfString("0x",
				options: NSStringCompareOptions.CaseInsensitiveSearch).location == 0)
			{
				hex = hex.substringFromIndex(2)
			}
			else if (hex.rangeOfString("#").location == 0)
			{
				hex = hex.substringFromIndex(1)
			}
			
			// Parse the hex color.
			result = _parseHexColor(hex)
		}
		
		return result
	}
	
	
	// MARK: - Private Methods
	
	private static func _parseHexColor(hex: NSString)
		-> UIColor?
	{
		var result: UIColor? = nil
		
		var hexInt: CUnsignedInt = 0
		
		let scanner: NSScanner = NSScanner(string: hex as String)
		
		scanner.scanHexInt(&hexInt)
		
		if (hex.length == 8)
		{
			result = UIColor(red: ((CGFloat)((hexInt & 0xFF000000) >> 24)) / CGFloat(255),
				green: ((CGFloat)((hexInt & 0xFF0000) >> 16)) / CGFloat(255),
				blue: ((CGFloat)((hexInt & 0xFF00) >> 8)) / CGFloat(255),
				alpha: ((CGFloat)(hexInt & 0xFF)) / CGFloat(255))
		}
		else if (hex.length == 6)
		{
			result = UIColor(red: ((CGFloat)((hexInt & 0xFF0000) >> 16)) / CGFloat(255),
				green: ((CGFloat)((hexInt & 0xFF00) >> 8)) / CGFloat(255),
				blue: ((CGFloat)(hexInt & 0xFF)) / CGFloat(255),
				alpha: 1);
		}
		
		return result;
	}
}