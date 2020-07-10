Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9321B7A2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jul 2020 16:02:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF9DC110605C1;
	Fri, 10 Jul 2020 07:02:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E16411003ED8
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 07:02:52 -0700 (PDT)
Received: from localhost (unknown [137.135.114.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A02E920857;
	Fri, 10 Jul 2020 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389771;
	bh=BWcfdF4SOViC4CYrJIgAVmv8l2cCHCM/PxYBkWm+YjE=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
	 References:From;
	b=bPoTabPa3MV9z1YgTwLHahC7PzUZbXEi1a1H3NhVoaW5dhzsmLcXp4nb1KqjSveWW
	 bM/dlUEKW8gr2D0i3zwnA5g+JTYiU6zuYoN/lMh/82FJFZ8Fpirf+kISKhigfgiowA
	 b31TZJQvClM8TDu2l2SIheee5y1J5gbdd7LdCjYk=
Date: Fri, 10 Jul 2020 14:02:51 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 01/12] libnvdimm: Validate command family indices
In-Reply-To: <159408711877.2385045.5738278265729770877.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711877.2385045.5738278265729770877.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-Id: <20200710140251.A02E920857@mail.kernel.org>
Message-ID-Hash: PWE6PJGVLVGY2KQEPHWQULSUH7VA2ST5
X-Message-ID-Hash: PWE6PJGVLVGY2KQEPHWQULSUH7VA2ST5
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PWE6PJGVLVGY2KQEPHWQULSUH7VA2ST5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism").

The bot has tested the following trees: v5.7.7, v5.4.50, v4.19.131, v4.14.187, v4.9.229.

v5.7.7: Failed to apply! Possible dependencies:
    f517f7925b7b4 ("ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods")

v5.4.50: Failed to apply! Possible dependencies:
    72c4ebbac476b ("powerpc/papr_scm: Mark papr_scm_ndctl() as static")
    f517f7925b7b4 ("ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods")

v4.19.131: Failed to apply! Possible dependencies:
    01091c496f920 ("acpi/nfit: improve bounds checking for 'func'")
    0ead11181fe0c ("acpi, nfit: Collect shutdown status")
    6f07f86c49407 ("acpi, nfit: Introduce nfit_mem flags")
    72c4ebbac476b ("powerpc/papr_scm: Mark papr_scm_ndctl() as static")
    b3ed2ce024c36 ("acpi/nfit: Add support for Intel DSM 1.8 commands")
    b5beae5e224f1 ("powerpc/pseries: Add driver for PAPR SCM regions")
    d6548ae4d16dc ("acpi/nfit, libnvdimm: Store dimm id as a member to struct nvdimm")
    f517f7925b7b4 ("ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods")

v4.14.187: Failed to apply! Possible dependencies:
    01091c496f920 ("acpi/nfit: improve bounds checking for 'func'")
    0e7f0741450b1 ("acpi, nfit: validate commands against the device type")
    1194c4133195d ("nfit: Add Hyper-V NVDIMM DSM command set to white list")
    11e1427016095 ("acpi, nfit: add support for NVDIMM_FAMILY_INTEL v1.6 DSMs")
    466d1493ea830 ("acpi, nfit: rework NVDIMM leaf method detection")
    4b27db7e26cdb ("acpi, nfit: add support for the _LSI, _LSR, and _LSW label methods")
    6f07f86c49407 ("acpi, nfit: Introduce nfit_mem flags")
    b37b3fd33d034 ("acpi nfit: Enable to show what feature is supported via ND_CMD_CALL for nfit_test")
    b9b1504d3c6d6 ("acpi, nfit: hide unknown commands from nmemX/commands")
    d6548ae4d16dc ("acpi/nfit, libnvdimm: Store dimm id as a member to struct nvdimm")

v4.9.229: Failed to apply! Possible dependencies:
    095ab4b39f91b ("acpi, nfit: allow override of built-in bitmasks for nvdimm DSMs")
    0f817ae696b04 ("usb: dwc3: pci: add a private driver structure")
    36daf3aa399c0 ("usb: dwc3: pci: avoid build warning")
    3f23df72dc351 ("mmc: sdhci-pci: Use ACPI to get max frequency for Intel NI byt sdio")
    41c8bdb3ab10c ("acpi, nfit: Switch to use new generic UUID API")
    42237e393f64d ("libnvdimm: allow a platform to force enable label support")
    42b06496407c0 ("mmc: sdhci-pci: Add PCI ID for Intel NI byt sdio")
    4b27db7e26cdb ("acpi, nfit: add support for the _LSI, _LSR, and _LSW label methods")
    6f07f86c49407 ("acpi, nfit: Introduce nfit_mem flags")
    8f078b38dd382 ("libnvdimm: convert NDD_ flags to use bitops, introduce NDD_LOCKED")
    94116f8126de9 ("ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()")
    9cecca75b5a0d ("usb: dwc3: pci: call _DSM for suspend/resume")
    9d62ed9651182 ("libnvdimm: handle locked label storage areas")
    b7fe92999a98a ("ACPI / extlog: Switch to use new generic UUID API")
    b917078c1c107 ("net: hns: Add ACPI support to check SFP present")
    ba650cfcf9409 ("acpi, nfit: allow specifying a default DSM family")
    c959a6b00ff58 ("mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices")
    d2061f9cc32db ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
    d6548ae4d16dc ("acpi/nfit, libnvdimm: Store dimm id as a member to struct nvdimm")
    fab9288428ec0 ("usb: USB Type-C connector class")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
