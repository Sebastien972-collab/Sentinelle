# Noctis

Un journal interactif centré sur le bien-être quotidien. Noctis vous accompagne dans l’exploration de vos pensées, le suivi de vos journées et la création de capsules temporelles pour observer votre évolution avec sérénité. L’expérience est volontairement simple, intime et apaisante — un espace personnel pour prendre du recul et cultiver l’équilibre. ✨
## Vision

Noctis a été conçu pour encourager des moments de pause et de clarté. À travers une interface épurée et des interactions réfléchies, l’application favorise une pratique régulière du journaling qui s’intègre naturellement dans la vie quotidienne. La fonctionnalité de capsule temporelle invite à revisiter vos états d’esprit passés pour mieux comprendre votre parcours.

## Fonctionnalités principales

- 📝 Écriture quotidienne
  - Créez des entrées libres ou guidées, rapidement et sans friction.
  - Sauvegarde automatique, édition fluide, tags et recherche.

- 📊 Suivi de l’humeur et des journées
  - Indicateurs simples pour capturer votre ressenti et vos habitudes.
  - Vue d’ensemble pour identifier tendances et progrès au fil du temps.

- ⏳ Capsules temporelles
  - Scellez des entrées et rouvrez-les à une date choisie.
  - Redécouvrez vos pensées avec contexte et bienveillance.

- 🔒 Confidentialité et sécurité
  - Stockage local priorisé et synchronisation iCloud (optionnelle).
  - Protection par Face ID / Touch ID (selon appareil).

- 🌙 Design apaisant
  - Interface minimaliste, typographie soignée et animations discrètes.
  - Thème sombre par défaut, confortable en soirée.

## Technologies

- Swift (concurrency moderne)
- SwiftUI (interface déclarative, animations)
- Observation / Combine ou Swift Concurrency pour la réactivité
- Swift Data / Core Data pour la persistance locale
- CloudKit / iCloud pour la synchronisation (optionnelle)
- WidgetKit pour les widgets (si applicable)
- StoreKit (si des achats intégrés sont proposés)
- XCTest / Swift Testing pour les tests

Note: La stack exacte peut varier selon la branche; consultez `Package.swift` et le projet Xcode pour le détail.

## Installation / Lancement du projet

1. Prérequis
   - Xcode 15+ (ou version indiquée dans le projet)
   - iOS 17+ comme cible minimale recommandée
   - Compte Apple Developer (pour exécuter sur appareil et activer iCloud)

2. Cloner le dépôt

