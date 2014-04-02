//
//  SKUMultiLineLabelNode.m
//  SGG_SKUtilities
//
//  Modified by Michael Redig on 3/11/14.
//	Original Credit goes to Chris Allwein of Downright Simple(c)
//	License remains the same

#import "SKUMultiLineLabelNode.h"

@interface SKUMultiLineLabelNode () {
	
	bool setupMode;
	
}

@end

@implementation SKUMultiLineLabelNode

#pragma mark init and convenience methods
- (instancetype) init
{
    self = [super init];
    
    if (self) {
        
		setupMode = YES;
		
        //Initialize the same values as a default SKLabelNode
        self.fontColor = [SKColor whiteColor];
        self.fontName = @"Helvetica";
        self.fontSize = 32.0;
		_lineSpacing = 1;
        
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        self.verticalAlignmentMode = SKLabelVerticalAlignmentModeBaseline;
        
        //Paint our initial texture
        [self retexture];
		
		setupMode = NO;
    }
    
    return self;
	
}

//init method to support drop-in replacement for SKLabelNode
- (instancetype)initWithFontNamed:(NSString *)fontName
{
    self = [self init];
    
    if (self) {
        self.fontName = fontName;
    }
    
    return self;
}

//Convenience method to support drop-in replacement for SKLabelNode
+ (instancetype)labelNodeWithFontNamed:(NSString *)fontName
{
    SKUMultiLineLabelNode* node = [[SKUMultiLineLabelNode alloc] initWithFontNamed:fontName];
    
    return node;
}

#pragma mark setters for SKLabelNode properties
//For each of the setters, after we set the appropriate property, we call the
//retexture method to generate and apply our new texture to the node

-(void) setFontColor:(SKColor *)fontColor
{
    _fontColor = fontColor;
    [self retexture];
}

-(void) setFontName:(NSString *)fontName
{
    _fontName = fontName;
    [self retexture];
}

-(void) setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    [self retexture];
}

-(void) setHorizontalAlignmentMode:(SKLabelHorizontalAlignmentMode)horizontalAlignmentMode
{
    _horizontalAlignmentMode = horizontalAlignmentMode;
    [self retexture];
}

-(void) setText:(NSString *)text
{
    _text = text;
    [self retexture];
}

-(void) setVerticalAlignmentMode:(SKLabelVerticalAlignmentMode)verticalAlignmentMode
{
    _verticalAlignmentMode = verticalAlignmentMode;
    [self retexture];
}

-(void)setParagraphWidth:(CGFloat)paragraphWidth {
	
	_paragraphWidth = paragraphWidth;
	[self retexture];
	
}

-(void)setLineSpacing:(CGFloat)lineSpacing {
	
	_lineSpacing = lineSpacing;
	[self retexture];
	
}

//Generates and applies new textures based on the current property values
-(void) retexture
{
    SKUImage *newTextImage = [self imageFromText:self.text];
	SKTexture *newTexture;
	
	if (newTextImage) {
		newTexture =[SKTexture textureWithImage:newTextImage];
	}
    
    SKSpriteNode *selfNode = (SKSpriteNode*) self;
    selfNode.texture = newTexture;
    
    //Resetting the texture also reset the anchorPoint.  Let's recenter it.
    selfNode.anchorPoint = CGPointMake(0.5, 0.5);
	
}




-(SKUImage*)imageFromText:(NSString *)text
{
    //First we define a paragrahp style, which has the support for doing the line breaks and text alignment that we require
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping; //To get multi-line
    paragraphStyle.alignment = [self mapSkLabelHorizontalAlignmentToNSTextAlignment:self.horizontalAlignmentMode];
    paragraphStyle.lineSpacing = _lineSpacing;
    
    //Create the font using the values set by the user
    SKUFont* font = [SKUFont fontWithName:self.fontName size:self.fontSize];
	
	if (!font) {
		font = [SKUFont fontWithName:@"Helvetica" size:self.fontSize];
		if (!setupMode) {
			NSLog(@"The font you specified was unavailable. Defaulted to Helvetica.");
			//		NSLog(@"The font you specified was unavailable. Defaulted to Helvetica. Here is a list of available fonts: %@", [DSMultiLineLabelFont familyNames]); //only available for debugging on iOS
			//		NSLog(@"Here is a list of variations to %@: %@", _fontName, [DSMultiLineLabelFont familyNames]);
		}
		
	}
    
    //Create our textAttributes dictionary that we'll use when drawing to the graphics context
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    
    //Font Name and size
    [textAttributes setObject:font forKey:NSFontAttributeName];
    
    //Line break mode and alignment
    [textAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	
    //Font Color
    [textAttributes setObject:self.fontColor forKey:NSForegroundColorAttributeName];
    
    
    //Calculate the size that the text will take up, given our options.  We use the full screen size for the bounds
	if (_paragraphWidth == 0) {
		_paragraphWidth = self.scene.size.width;
	}
#if TARGET_OS_IPHONE
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(_paragraphWidth, self.scene.size.height)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:textAttributes
                                         context:nil];
	
#else
	CGRect textRect = [text boundingRectWithSize:CGSizeMake(_paragraphWidth, self.scene.size.height)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:textAttributes];
#endif
    //iOS7 uses fractional size values.  So we needed to ceil it to make sure we have enough room for display.
    textRect.size.height = ceil(textRect.size.height);
    textRect.size.width = ceil(textRect.size.width);
	
	//Mac build crashes when the size is nothing - this also skips out on unecessary cycles below when the size is nothing
	if (textRect.size.width == 0 || textRect.size.height == 0) {
		return Nil;
	}
    
    //The size of the bounding rect is going to be the size of our new node, so set the size here.
    SKSpriteNode *selfNode = (SKSpriteNode*) self;
    selfNode.size = textRect.size;
    
#if TARGET_OS_IPHONE
    //Create the graphics context
    UIGraphicsBeginImageContextWithOptions(textRect.size,NO,0.0);
    
    //Actually draw the text into the context, using our defined attributed
    [text drawInRect:textRect withAttributes:textAttributes];
    
    //Create the image from the context
    SKUImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    //Close the context
    UIGraphicsEndImageContext();
#else
	
	SKUImage* image = [[SKUImage alloc] initWithSize:textRect.size];
	/*
	 // this section may or may not be necessary (it builds and runs without, but I don't have enough experience to know if this makes things run smoother in any way, or if the stackexchange article was entirely purposed for something else)
	 NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:textRect.size.width pixelsHigh:textRect.size.height bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace bytesPerRow:0 bitsPerPixel:0];
	 
	 [image addRepresentation:imageRep];
	 
	 */
	[image lockFocus];
	
	[text drawInRect:textRect withAttributes:textAttributes];
	
	[image unlockFocus];
	
	
#endif
    
    return image;
}

//Performs translation between the SKLabelHorizontalAlignmentMode supported by SKLabelNode and the NSTextAlignment required for string drawing

#if TARGET_OS_IPHONE

-(NSTextAlignment) mapSkLabelHorizontalAlignmentToNSTextAlignment:(SKLabelHorizontalAlignmentMode)alignment
{
    switch (alignment) {
        case SKLabelHorizontalAlignmentModeLeft:
            return NSTextAlignmentLeft;
            break;
            
        case SKLabelHorizontalAlignmentModeCenter:
            return NSTextAlignmentCenter;
            break;
            
        case SKLabelHorizontalAlignmentModeRight:
            return NSTextAlignmentRight;
            break;
            
        default:
            break;
    }
    
    return NSTextAlignmentLeft;
}

#else

-(NSTextAlignment) mapSkLabelHorizontalAlignmentToNSTextAlignment:(SKLabelHorizontalAlignmentMode)alignment
{
    switch (alignment) {
        case SKLabelHorizontalAlignmentModeLeft:
            return kCTTextAlignmentLeft;
            break;
            
        case SKLabelHorizontalAlignmentModeCenter:
            return kCTTextAlignmentCenter;
            break;
            
        case SKLabelHorizontalAlignmentModeRight:
            return kCTTextAlignmentRight;
            break;
            
        default:
            break;
    }
    
    return kCTTextAlignmentLeft;
}

#endif

@end
