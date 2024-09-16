
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Task where Success == Never, Failure == Never {
	public struct Duration: RawRepresentable {
		public var rawValue: UInt64
		public var nanoseconds: UInt64 {
			get { rawValue }
			set { rawValue = newValue }
		}

		public init(rawValue: UInt64) {
			self.rawValue = rawValue
		}

		public var seconds: Double {
			get { Double(nanoseconds) / .oneBillion }
			set { nanoseconds = UInt64(newValue * .oneBillion) }
		}

		public var milliseconds: Double {
			get { Double(nanoseconds) / .oneMillion }
			set { nanoseconds = UInt64(newValue * .oneMillion) }
		}

		public var microseconds: UInt64 {
			get { nanoseconds / .oneThousand }
			set { nanoseconds = newValue * .oneThousand }
		}

		static public func nanoseconds(_ value: UInt64) -> Duration {
			Duration(rawValue: value)
		}

		static public func microseconds(_ value: UInt64) -> Duration {
			var new = Duration(rawValue: 0)
			new.microseconds = value
			return new
		}

		static public func milliseconds(_ value: Double) -> Duration {
			var new = Duration(rawValue: 0)
			new.milliseconds = value
			return new
		}

		static public func seconds(_ value: Double) -> Duration {
			var new = Duration(rawValue: 0)
			new.seconds = value
			return new
		}
	}

	public static func sleep(backportDuration duration: Duration) async throws {
		try await Task.sleep(nanoseconds: duration.nanoseconds)
	}
}

extension BinaryFloatingPoint {
	static var oneBillion: Self { 1_000_000_000 }
	static var oneMillion: Self { 1_000_000 }
	static var oneThousand: Self { 1_000 }
}

extension BinaryInteger {
	static var oneBillion: Self { 1_000_000_000 }
	static var oneMillion: Self { 1_000_000 }
	static var oneThousand: Self { 1_000 }
}
