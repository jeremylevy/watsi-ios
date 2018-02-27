//
//  PatientsListPageViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 02/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit
import PageMenu

private let patientsListViewControllerIdentifier = "patientsListCollectionViewController"

class PatientsListPageViewController: UIViewController {
    
    // MARK: - Custom properties
    
    var pageMenu: CAPSPageMenu?
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configurePageMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()
    }
    
    // MARK: - Custom methods
    
    func configureNavigationBar() {
        self.navigationItem.title = "Patients"
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationBarTitleTextColor()]
        self.navigationController?.navigationBar.barTintColor = Color.navigationBarBackgroundColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func configurePageMenu() {
        var controllersToSetInPages: [UIViewController] = [];
        
        let storyboard = UIStoryboard(name: Config.DEFAULT_STORYBOARD_NAME, bundle: nil)
        
        let startedPatientsListCollectionViewController = storyboard.instantiateViewController(withIdentifier: patientsListViewControllerIdentifier) as! PatientsListCollectionViewController
        
        let newPatientsListCollectionViewController = storyboard.instantiateViewController(withIdentifier: patientsListViewControllerIdentifier) as! PatientsListCollectionViewController
        
        // Used as page item title
        startedPatientsListCollectionViewController.title = "Démarrés"
        newPatientsListCollectionViewController.title = "Nouveaux"
        
        startedPatientsListCollectionViewController.patientType = .STARTED
        newPatientsListCollectionViewController.patientType = .NEW
        
        controllersToSetInPages.append(startedPatientsListCollectionViewController)
        controllersToSetInPages.append(newPatientsListCollectionViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(Color.pageMenuScrollMenuBackgroundColor()),
            .viewBackgroundColor(Color.pageMenuViewBackgroundColor()),
            .selectionIndicatorColor(Color.pageMenuSelectionIndicatorColor()),
            .bottomMenuHairlineColor(Color.pageMenuBottomMenuHairlineColor()),
            .selectedMenuItemLabelColor(Color.pageMenuSelectedMenuItemLabelColor()),
            .unselectedMenuItemLabelColor(Color.pageMenuUnselectedMenuItemLabelColor()),
            .selectionIndicatorHeight(2.0),
            .menuItemFont(UIFont.systemFont(ofSize: 14.0)),
            .menuHeight(41.0),
            .menuItemWidth(80.0),
            .menuMargin(0.0),
            .menuItemSeparatorRoundEdges(true),
            .centerMenuItems(true)
        ]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllersToSetInPages,
                                     frame: CGRect(x: 0.0, y: 0.0,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height),
                                     pageMenuOptions: parameters)
        
        self.view.addSubview(self.pageMenu!.view)
        
        self.addChildViewController(self.pageMenu!)
        
        self.pageMenu?.didMove(toParentViewController: self)
    }
}
