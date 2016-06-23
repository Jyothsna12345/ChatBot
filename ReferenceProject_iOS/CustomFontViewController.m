//Drag Drop Custome Font File into Project.
//Goto project -> Select "Bundle Phase" ->Select "Copy Bundle Resources" -> Click On "+" icon at the bottom -> Choose "Custom File".
//Go to "Info.plist" -> Right Click Mouse and Select "Add Row" -> Add "Fonts provided by application" as Key and "Custome File Name With Extension" as Value.


#import "CustomFontViewController.h"

@interface CustomFontViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIButton *changeFontButton;

@end

@implementation CustomFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.hidesBackButton=NO;
    [_changeFontButton setTitle:@"Change to Custom Font" forState:normal];
    _detailTextView.font=[UIFont systemFontOfSize:14];
    _detailTextView.text=@"A font is a particular size, weight and style of a typeface. Each font was a matched set of type, one piece for each glyph, and a typeface consisting of a range of fonts that shared an overall design. In modern usage, with the advent of digital typography, font is frequently synonymous with typeface, although the two terms do not necessarily mean the same thing. In particular, the use of vector or outline fonts means that different sizes of a typeface can be dynamically generated from one design. Each style may still be in a separate font file—for instance, the typeface Bulmer may include the fonts Bulmer roman, Bulmer italic, Bulmer bold and Bulmer extended—but the term font might be applied either to one of these alone or to the whole typeface.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)changeFont:(id)sender {
    if ([_changeFontButton.currentTitle isEqualToString:@"Change to Custom Font"]) {
        [_changeFontButton setTitle:@"Change to System Font" forState:normal];
        _detailTextView.font=[UIFont fontWithName:@"OpenSans-ExtraBoldItalic" size:14];
    }else{
        [_changeFontButton setTitle:@"Change to Custom Font" forState:normal];
        _detailTextView.font=[UIFont systemFontOfSize:14];
    }
}

@end
