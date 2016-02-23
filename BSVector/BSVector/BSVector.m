//
//  BSVector.m
//  BSVector
//
//  Created by AugustRush on 2/6/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import "BSVector.h"

typedef struct Node {
    CGFloat element;
    struct Node *next;
} Node;

@implementation BSVector {
    size_t _count;
    Node *_node;
}

- (instancetype)initWithValues:(CGFloat *)values count:(size_t)count {
    self = [super init];
    if (self) {
        _count = count;
        _node = (Node *)malloc(sizeof(Node));
        if (_node != NULL) {
            Node *cNode = _node;
            for (int i = 0; i < count - 1; i++) {
                cNode->element = values[i];
                Node *nNode = (Node *)malloc(sizeof(Node));
                cNode->next = nNode;
                //new
                nNode->element = values[i + 1];
                //current node
                cNode = nNode;
            }
        }
    }
    return self;
}

- (void)clearAllNodes {
    Node *nextNode;
    while (_node != NULL) {
        nextNode = _node->next;
        free(_node);
        _node = nextNode;
    }
    _count = 0;
}

- (void)dealloc {
    [self clearAllNodes];
}

@end
