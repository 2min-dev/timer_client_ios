//
//  AppInfoViewController.swift
//  timer
//
//  Created by Jeong Jin Eun on 13/04/2019.
//  Copyright © 2019 Jeong Jin Eun. All rights reserved.
//

import RxSwift
import ReactorKit

class AppInfoViewController: BaseViewController, View {
	// MARK: view properties
	private var appInfoView: AppInfoView { return view as! AppInfoView }
	
	// MARK: properties
	var coordinator: AppInfoCoordinator!

	// MARK: lifecycle
	override func loadView() {
		view = AppInfoView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	// MARK: reactor bind
	func bind(reactor: AppInfoViewReactor) {
		// MARK: action

		// MARK: state
	}
    
    deinit {
        Logger.verbose()
    }
} 