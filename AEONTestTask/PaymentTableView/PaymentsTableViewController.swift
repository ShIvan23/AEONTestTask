//
//  PaymentsTableViewController.swift
//  AEONTestTask
//
//  Created by Ivan on 17.04.2021.
//

import UIKit

class PaymentsTableViewController: UITableViewController {
    
    // MARK: - Public Priperties
    var token: String?
    
    // MARK: - Private Properties
    private let apiManager = AEONManager()
    private var paymentsArray = [Response]()
       
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PaymentsViewCell", bundle: nil), forCellReuseIdentifier: "PaymentsCell")
        getPayments()
        setupLayout()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    private func getPayments() {
        guard let token = token else { return }
        apiManager.getPayments(token: token) { [weak self] (result) in
            
            switch result {
            case .success(let payments):
                self?.paymentsArray = payments.response
                    .filter ({$0.currency != nil &&
                                $0.currency != "" })
                
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupNavigationBar() {
        let barButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutPressed))
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    private func setupLayout() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    @objc private func logOutPressed() {
        token = nil
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCell", for: indexPath) as! PaymentsViewCell

        let payment = paymentsArray[indexPath.row]
        cell.createCell(payment: payment)

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
