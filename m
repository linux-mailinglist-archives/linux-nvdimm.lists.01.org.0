Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E32038AC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 16:03:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA13A10FC3777;
	Mon, 22 Jun 2020 07:03:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3EDE10FCB777
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 07:03:24 -0700 (PDT)
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3ee201f6baf16c43; Mon, 22 Jun 2020 16:03:22 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH v2 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI memory inside of the AML interpreter
Date: Mon, 22 Jun 2020 15:50:42 +0200
Message-ID: <2713141.s8EVnczdoM@kreacher>
In-Reply-To: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: WLYST234OJJB25Z5SY227SDWE64TMJCO
X-Message-ID-Hash: WLYST234OJJB25Z5SY227SDWE64TMJCO
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WLYST234OJJB25Z5SY227SDWE64TMJCO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi All,

This series is to address the problem with RCU synchronization occurring,
possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
when the namespace and interpreter mutexes are held.

Like I said before, I had decided to change the approach used in the previous
iteration of this series and to allow the unmap operations carried out by 
acpi_ex_system_memory_space_handler() to be deferred in the first place,
which is done in patches [1-2/4].

However, it turns out that the "fast-path" mapping is still useful on top of
the above to reduce the number of ioremap-iounmap cycles for the same address
range and so it is introduced by patches [3-4/4].

For details, please refer to the patch changelogs.

The series is available from the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpica-osl

for easier testing.

Cheers,
Rafael





_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
