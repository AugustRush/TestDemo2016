
protocol NominalType : MetadataType {
    var nominalTypeDescriptorOffsetLocation: Int { get }
}

extension NominalType {
    
    var nominalTypeDescriptor: NominalTypeDescriptor {
        let base = UnsafePointer<Int>(pointer).advanced(by: nominalTypeDescriptorOffsetLocation)
        return NominalTypeDescriptor(pointer: relativePointer(base: base, offset: base.pointee))
    }
    
    var fieldTypes: [Any.Type] {
        guard let function = nominalTypeDescriptor.fieldTypesAccessor else { return [] }
        return (0..<nominalTypeDescriptor.numberOfFields).map {
            unsafeBitCast(function(UnsafePointer<Int>(pointer)).advanced(by: $0).pointee, to: Any.Type.self)
        }
    }
    
}
