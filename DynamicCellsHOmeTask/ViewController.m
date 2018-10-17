//
//  ViewController.m
//  DynamicCellsHOmeTask
//
//  Created by Roman Berezin on 16.10.2018.
//  Copyright © 2018 Roman Berezin. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"


typedef enum {
    best,
    good,
    setisfied,
    bad
} Groups;

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* array;
@property (strong, nonatomic) TestClass* object;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    
    for (int i = 0; i <= 30; i++) {
        TestClass* object = [[TestClass alloc] init];
        object.color = [UIColor blackColor];
        object.name = [self randomName];
        object.mark = [self randomMiddleMark];
        [self.array addObject:object];

    }
    
}



#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.array count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifier = @"Cell";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    self.object = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.object.name];
    
    if (self.object.mark < 4) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = self.object.color;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.object.mark];
    
    
return cell;

    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UIColor* color = [self randomColor];
    
    cell.textLabel.text = [NSString stringWithFormat:@"(%.2f)", [color description]];
    cell.textLabel.textColor = color;
    
    return cell;
}
*/

#pragma mark - Private Methods

- (UIColor *) randomColor {
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
}

- (NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (NSString *) randomName {

    NSString* names = @"Roman, Lina, Artem, Leha, Tantal, Pudra, Dima, Alex, Igor', Jenya, Lena, Andrey, Mariya, Vladimir, Marina, Arkasha, Kolya, Petrivna, Mitrofanovna, Olga, Dasha, Inna, Natasha, Il'ya, Genry, John, Nastya, Misha, Moisey, Bublik";
        
    NSArray* array = [names componentsSeparatedByString:@", "];
    return [array objectAtIndex:arc4random() % 30];
    
}

- (int) randomMiddleMark {
    
    int mark = (arc4random() % 5) + 1;
    
    return mark;
}

@end
