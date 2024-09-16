import Testing
@testable import SSBTaskSleep
import Foundation

@Test
func testTaskSecondSleep() async throws {
	let start = getTime()

	try await Task.sleep(backportDuration: .seconds(1))

	let end = getTime()

	let difference = abs(end.seconds - start.seconds)

	#expect((0.93..<1.07).contains(difference))
}

private func getTime() -> timespec {
	var timeHolder = timespec()
	clock_gettime(CLOCK_MONOTONIC_RAW, &timeHolder)
	return timeHolder
}

private extension timespec {
	var seconds: Double {
		Double(tv_sec) + (Double(tv_nsec) / .oneBillion)
	}
}
