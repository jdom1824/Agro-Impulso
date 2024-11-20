# **Contratos Inteligentes para la Gestión de Stakeholders e Implementación de Proyectos**

Este repositorio contiene dos contratos inteligentes diseñados para administrar y supervisar proyectos mediante blockchain. Los contratos están basados en los estándares ERC-20 y ERC-721 de OpenZeppelin, y cuentan con funcionalidades personalizadas para garantizar la transparencia, trazabilidad y no transferibilidad de los tokens.

---

## **1. StakeholderToken (ERC-20)**
El contrato **StakeholderToken** emite tokens no transferibles para los stakeholders del proyecto. Estos tokens representan la participación de cada stakeholder y les permiten monitorear el uso de recursos asignados.

### **Características principales:**
- **No transferibilidad:** Los tokens no pueden ser transferidos entre cuentas, garantizando que cada stakeholder retenga exclusivamente su participación.
- **Distribución controlada:** Solo el administrador del contrato puede asignar tokens a los stakeholders.
- **Quema de tokens:** Los stakeholders pueden quemar sus tokens si es necesario.
- **Actualización del administrador:** El administrador puede delegar su rol a otra dirección, asegurando flexibilidad en la gestión.

### **Funciones principales:**
- `distribute(address stakeholder, uint256 amount)`: Permite al administrador distribuir tokens a los stakeholders.
- `burn(uint256 amount)`: Permite a los stakeholders quemar sus propios tokens.
- `updateAdmin(address newAdmin)`: Cambia la dirección del administrador.

---

## **2. ProjectStages (ERC-721)**
El contrato **ProjectStages** gestiona las etapas de implementación del proyecto. Cada etapa se representa como un token único (ERC-721) que incluye metadatos específicos relacionados con el progreso.

### **Características principales:**
- **No transferibilidad:** Los tokens ERC-721 no pueden ser transferidos entre cuentas, asegurando que cada etapa esté vinculada exclusivamente al proyecto.
- **Creación de etapas:** Solo el administrador puede crear nuevas etapas del proyecto.
- **Registro de detalles:** Cada etapa incluye un nombre, descripción, estado de finalización y una marca de tiempo.
- **Finalización de etapas:** El administrador puede marcar una etapa como completada.
- **Actualización del administrador:** Se permite transferir el rol de administrador a otra dirección.

### **Funciones principales:**
- `createStage(string memory name, string memory description, string memory uri)`: Crea una nueva etapa del proyecto con metadatos únicos.
- `completeStage(uint256 stageId)`: Marca una etapa como completada.
- `updateAdmin(address newAdmin)`: Cambia la dirección del administrador.

---

## **Requisitos de instalación**
Para implementar los contratos, es necesario contar con las siguientes herramientas instaladas:
- **Node.js** y **npm**
- **Hardhat** para el desarrollo y pruebas de contratos inteligentes
- Biblioteca de OpenZeppelin:
  ```bash
  npm install @openzeppelin/contracts
