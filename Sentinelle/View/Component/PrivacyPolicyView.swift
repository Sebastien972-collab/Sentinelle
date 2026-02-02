//
//  PrivacyPolicyView.swift
//  Sentinelle
//
//  Created by Sebby on 21/11/2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Politique de confidentialité – Aucune collecte de données personnelles")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)
                
                Text("Dernière mise à jour : 21 Novembre 2024")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("""
                    Chez Sébastien DAGUIN Group ("nous", "notre", "nos"), nous accordons une grande importance à la confidentialité et à la sécurité des informations de nos utilisateurs. Nous souhaitons vous informer clairement que nous ne collectons, n'enregistrons ni n'accédons à aucune donnée relative à vos journaux personnels dans l'application.
                    
                    Données personnelles :
                    - Nous ne collectons aucune information personnelle identifiable (nom, adresse, email, etc.) dans le cadre de l'utilisation des journaux ou de toute autre fonctionnalité de l'application.
                    - Les journaux et données de santé ou émotionnelle que vous enregistrez dans l'application sont stockés uniquement localement sur votre appareil, et nous n'y avons aucun accès. Ils ne sont pas partagés avec des serveurs distants ou d'autres services en ligne.
                    - Aucune donnée n'est envoyée ni collectée à des fins commerciales, de publicité ou d'analyse de comportement utilisateur.
                    
                    Sécurité et confidentialité des données :
                    - Toutes les informations que vous entrez dans l'application (par exemple, vos journaux personnels) sont protégées par les mécanismes de sécurité standards de votre appareil, comme le verrouillage de l'écran et le cryptage local.
                    - Nous respectons pleinement votre vie privée et garantissons que vous avez le contrôle total sur les données que vous choisissez d'entrer dans l'application.
                    
                    Partage de données :
                    - Aucune donnée n'est partagée avec des tiers, et nous ne collectons pas d'informations sur vos activités ou comportements au sein de l'application.
                    
                    Modification ou suppression des données :
                    - Vous pouvez à tout moment consulter, modifier ou supprimer les journaux que vous avez enregistrés. Aucune information n'est conservée ou synchronisée sans votre consentement.
                    
                    Nous vous encourageons à lire notre Politique de confidentialité complète pour plus de détails sur la façon dont nous protégeons vos informations. Si vous avez des questions concernant la sécurité de vos données, n'hésitez pas à nous contacter.
                    """)
                .font(.body)
                .padding(.bottom, 16)
            }
            .padding()
        }
        .navigationBarTitle("Politique de Confidentialité", displayMode: .inline)
    }
}
#Preview {
    PrivacyPolicyView()
}
