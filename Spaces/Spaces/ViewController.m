//
//  ViewController.m
//  Spaces
//
//  Created by KONG on 2021/3/19.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property (nonatomic, strong) SCNView *scnView;
@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) SCNNode *earthNode;
@property (nonatomic, strong) SCNNode *gzEarthNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScnView];
    
    [self addCamera];
    [self addLight];
    [self addSun];
    [self addEarth];
    [self addMoon];
    
    [self addAuthor];
}

- (void)initScnView{
    [self.view addSubview:self.scnView];
    self.scnView.scene = self.scene;
}

- (void)addCamera{
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 0, 10);
    [self.scene.rootNode addChildNode:cameraNode];
}

- (void)addLight{
    SCNLight *strongLight = [SCNLight light];
    strongLight.intensity = 2200;
    SCNNode *strongLightNode = [SCNNode node];
    strongLightNode.light = strongLight;
    strongLightNode.position = SCNVector3Make(0, 0, 0);
    [self.scene.rootNode addChildNode:strongLightNode];
    
    SCNLight *ambientLight =[SCNLight light];
    ambientLight.intensity = 50;
    ambientLight.type = SCNLightTypeAmbient;
    SCNNode * ambientLightNode = [SCNNode node];
    ambientLightNode.light = ambientLight;
    [self.scene.rootNode addChildNode:ambientLightNode];
}

- (void)addSun{
    SCNScene *sunScene = [SCNScene sceneNamed:@"SceneKit Asset Catalog.scnassets/Fire.scn"];
    SCNNode *sunNode = [sunScene.rootNode childNodeWithName:@"Fire" recursively:YES];
    sunNode.position = SCNVector3Make(0, 0, 0);
    [self.scene.rootNode addChildNode:sunNode];
}

- (void)addEarth{
    
    SCNNode *gzNode = [SCNNode node];
    SCNSphere *gzSphere = [SCNSphere sphereWithRadius:0.1];
    gzSphere.firstMaterial.diffuse.contents = [UIColor clearColor];
    gzNode.geometry = gzSphere;
    gzNode.position = SCNVector3Make(0, 0, 0);
    SCNAction *gzAction = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 * M_PI_2 z:0 duration:10]];
    [gzNode runAction:gzAction];
    [self.scene.rootNode addChildNode:gzNode];
    self.gzEarthNode = gzNode;
    
    SCNSphere *earthSphere = [SCNSphere sphereWithRadius:0.3];
    earthSphere.firstMaterial.diffuse.contents = [UIImage imageNamed:@"earth"];
    SCNNode *earthNode = [SCNNode nodeWithGeometry:earthSphere];
    earthNode.position = SCNVector3Make(-5, 0, 0);
    SCNAction *action = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:-2 * M_PI_2 z:0 duration:3]];
    [earthNode runAction:action];
    [gzNode addChildNode:earthNode];
    self.earthNode = earthNode;
}

- (void)addMoon{

    SCNNode *gzMoonNode = [SCNNode node];
    SCNSphere *gzMoonSphere = [SCNSphere sphereWithRadius:0.1];
    gzMoonSphere.firstMaterial.diffuse.contents = [UIColor redColor];
    gzMoonNode.geometry = gzMoonSphere;
    SCNAction *gzMoonAction = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 *M_PI z:0 duration:3]];
    [gzMoonNode runAction:gzMoonAction];
    gzMoonNode.position = self.earthNode.position;
    [self.gzEarthNode addChildNode:gzMoonNode];
    
    SCNSphere *moonSphere = [SCNSphere sphereWithRadius:0.12];
    moonSphere.firstMaterial.diffuse.contents = [UIColor lightGrayColor];
    SCNNode *moonNode = [SCNNode nodeWithGeometry:moonSphere];
    moonNode.position = SCNVector3Make(-1, 0, 0);
    [gzMoonNode addChildNode:moonNode];
}

- (void)addAuthor{
    
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEE"];
    // 获取当前日期
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Create By : 孔";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = [NSString stringWithFormat:@"At : %@",currentDateString];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"For : Everyone who are wacthing now...✌️";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor whiteColor];
    
    label.frame = CGRectMake(30, 20, 0, 20);
    label1.frame = CGRectMake(30, 40, 0, 20);
    label2.frame = CGRectMake(30, 60, 0, 20);
    [label sizeToFit];
    [label1 sizeToFit];
    [label2 sizeToFit];
    
    [self.view addSubview:label];
    [self.view addSubview:label1];
    [self.view addSubview:label2];
}

#pragma mark -
#pragma mark --- * Lazy * ---
- (SCNView *)scnView{
    if (!_scnView) {
        _scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _scnView.allowsCameraControl = YES;
        _scnView.showsStatistics = YES;
    }
    return _scnView;
}

- (SCNScene *)scene{
    if (!_scene) {
        _scene = [SCNScene sceneNamed:@"SceneKit Asset Catalog.scnassets/Star.scn"];
        _scene.background.contents = [UIColor blackColor];
    }
    return _scene;
}


@end
