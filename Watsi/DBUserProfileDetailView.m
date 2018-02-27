//
//  DBUserProfileDetailView.m
//  DBProfileViewController
//
//  Created by Devon Boyer on 2016-03-21.
//  Copyright © 2016 Devon Boyer. All rights reserved.
//

#import "DBUserProfileDetailView.h"

@interface DBUserProfileDetailView ()

@property (nonatomic, strong) UIView *supplementaryView;
@property (nonatomic, strong) NSLayoutConstraint *supplementaryViewHeightConstraint;
@property (nonatomic, assign) BOOL showingSupplementaryView;

@end

@implementation DBUserProfileDetailView

- (instancetype)init {
    self = [super init];
    if (self) {
        _supplementaryView = [[UIView alloc] init];
        _contentView = [[UIView alloc] init];
        _nameLabel = [[UILabel alloc] init];
        _usernameLabel = [[UILabel alloc] init];
        _descriptionLabel = [[UILabel alloc] init];

        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.descriptionLabel];
        
        self.supplementaryView.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.nameLabel.numberOfLines = 0;
        self.usernameLabel.numberOfLines = 0;
        self.descriptionLabel.numberOfLines = 0;
        
        [self addSubview:self.supplementaryView];
        [self addSubview:self.contentView];
        
        [self configureSupplementaryViewLayoutConstraints];
        [self configureContentViewLayoutConstraints];
        [self configureNameLabelLayoutConstraints];
        [self configureUsernameLabelLayoutConstraints];
        [self configureDescriptionLabelLayoutConstraints];
        
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:42/255.0 alpha:1];
                
        self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
        self.usernameLabel.font = [UIFont systemFontOfSize:14];
        self.descriptionLabel.font = [UIFont systemFontOfSize:16];
        
        self.supplementaryView.backgroundColor = [UIColor colorWithRed:245/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
    }
    
    return self;
}

- (void)edit {
    self.showingSupplementaryView = !self.showingSupplementaryView;
    [self showSupplementaryView];
    [self.delegate userProfileDetailView:self didShowSupplementaryView:self.supplementaryView];
}

- (void)showSupplementaryView {
    self.supplementaryViewHeightConstraint.constant = self.showingSupplementaryView ? 200 : 0;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.nameLabel.textColor = self.tintColor;
    self.usernameLabel.textColor = [self.tintColor colorWithAlphaComponent:0.54];
    self.descriptionLabel.textColor = [self.tintColor colorWithAlphaComponent:0.72];
}

#pragma mark - Auto Layout

- (void)configureSupplementaryViewLayoutConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.supplementaryView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:54]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.supplementaryView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.supplementaryView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    self.supplementaryViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.supplementaryView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self addConstraint:self.supplementaryViewHeightConstraint];
}

- (void)configureContentViewLayoutConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.supplementaryView attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
}

- (void)configureNameLabelLayoutConstraints {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

- (void)configureUsernameLabelLayoutConstraints {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

- (void)configureDescriptionLabelLayoutConstraints {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.usernameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

@end
