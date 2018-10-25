//
//  ViewController.m
//  DynamicCellsHOmeTask
//
//  Created by Roman Berezin on 16.10.2018.
//  Copyright © 2018 Roman Berezin. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"



@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* array;
@property (strong, nonatomic) NSArray* arrayOfGroups;
@property (strong, nonatomic) TestClass* object;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    self.arrayOfGroups = [NSArray arrayWithObjects: @"Best", @"Good", @"Setisfied", @"Bad", nil];
    for (int i = 0; i < 30; i++) {
        TestClass* object = [[TestClass alloc] init];
        object.color = [UIColor blackColor];
        object.name = [self randomName];
        object.mark = [self randomMiddleMark];
        [self.array addObject:object];
    }
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView %d", (int)[self.arrayOfGroups count]);
   
    return [self.arrayOfGroups count];
}  //сколько секций

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSString* groupName = [self.arrayOfGroups objectAtIndex:section];
    
    NSArray* groupOfObjects = [[self parsingOfArrayByValue] objectForKey:groupName];
    
    return [groupOfObjects count];
    
} //сколько строк в секции ()

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString* group = [self.arrayOfGroups objectAtIndex:section];
    NSLog(@"titleForHeaderInSection %@  for section %d", group, (int)section);
    return group;
}//название хэдэров секций

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifier = @"Cell";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    NSString* groupName = [self.arrayOfGroups objectAtIndex:indexPath.section];
    
    NSArray* groupOfObjects = [[self parsingOfArrayByValue] objectForKey:groupName];

    TestClass* object = [groupOfObjects objectAtIndex:indexPath.row];
    
    NSString* objectName = object.name;
    
    NSLog(@"Object name for section %d and raw %d is %@", (int)indexPath.section, (int) indexPath.row, objectName);
    cell.textLabel.text = objectName;
   
    if (object.mark < 4) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = object.color;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)object.mark];
    
    
return cell;

    
} // отрисовка таблицы

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

- (NSMutableDictionary *) parsingOfArrayByValue{
    
    NSMutableArray* arrayWithBest = [[NSMutableArray alloc] init];
    NSMutableArray* arrayWithGood = [[NSMutableArray alloc] init];
    NSMutableArray* arrayWithSetisfied = [[NSMutableArray alloc] init];
    NSMutableArray* arrayWithBad = [[NSMutableArray alloc] init];
    
    
    for (TestClass* obj in self.array) {
        if (obj.mark == 5) {
            [arrayWithBest addObject:obj];
        }
        if (obj.mark == 4) {
            [arrayWithGood addObject:obj];
        }
        if (obj.mark == 3) {
            [arrayWithSetisfied addObject:obj];
        }
        if (obj.mark == 2) {
            [arrayWithBad addObject:obj];
        }
    }
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:arrayWithBest forKey:@"Best"];
    [dict setObject:arrayWithGood forKey:@"Good"];
    [dict setObject:arrayWithSetisfied forKey:@"Setisfied"];
    [dict setObject:arrayWithBad forKey:@"Bad"];
    
    
    return dict;
}


@end
