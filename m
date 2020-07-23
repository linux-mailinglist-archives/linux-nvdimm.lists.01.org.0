Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC222A720
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 07:58:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BA37124D8F79;
	Wed, 22 Jul 2020 22:58:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C21F9100A6D7A
	for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 22:57:57 -0700 (PDT)
IronPort-SDR: GYf1MOQBMdoi68rL3J6btfgu9imFlgLDDinsexsiVcBqwbhXdb3zK/hJRcabED7Zmx/ggXqjGn
 QAP95ehuTLbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="215086612"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800";
   d="scan'208";a="215086612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 22:57:57 -0700
IronPort-SDR: o4AEnXvFEfx2+X2l8VlvBuzC+RuC4+M/5nafwMNRvEHxx3NqiXoxJ8LktP+xO/hvYGsvusYGYc
 w7PaKjo900Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800";
   d="scan'208";a="288529407"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2020 22:57:57 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.107]) with mapi id 14.03.0439.000;
 Wed, 22 Jul 2020 22:57:57 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [ANNOUNCE] ndctl v69
Thread-Topic: [ANNOUNCE] ndctl v69
Thread-Index: AQHWYLY2bA6BdwHxAkODEB2k577TFw==
Date: Thu, 23 Jul 2020 05:57:56 +0000
Message-ID: <4205dc57a8ebfef2698fa09c8029f32efed6c3dd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.255.75.57]
Content-ID: <701A0E7EBACD8A4A9B025F5E007C1374@intel.com>
MIME-Version: 1.0
Message-ID-Hash: IZOI5RXK2OXY6FUEVFGFVTYFJAQPJOWS
X-Message-ID-Hash: IZOI5RXK2OXY6FUEVFGFVTYFJAQPJOWS
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IZOI5RXK2OXY6FUEVFGFVTYFJAQPJOWS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A new ndctl release is available[1].

Highlights include support for 'PAPR' NVDIMMs, a build fix for
zero-length array warnings in GCC10, a new option for ndctl-monitor
allowing for a timeout for epoll, and misc unit test and documentation
fixes.

A shortlog is appended below.

[1]: https://github.com/pmem/ndctl/releases/tag/v69

Dan Williams (1):
      ndctl/build: Fix zero-length array warnings

Michal Suchanek (1):
      Documentation: use includes in more ndctl command pages.

Santosh Sivaraj (2):
      Skip region filtering if numa_node attribute is not present
      infoblock: Set the default alignment to the platform alignment

Steve Scargall (1):
      ndctl/doc: Fix a typo in Documentation/daxctl/movable-options.txt

Vaibhav Jain (8):
      libndctl: Refactor out add_dimm() to handle NFIT specific init
      libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
      libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
      papr: Add scaffolding to issue and handle PDSM requests
      libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH
      monitor: Add epoll timeout for forcing a full dimm health check
      libndctl/papr_scm: Add support for reporting "life_used_percentage" metric
      papr: Check for command type in papr_xlat_firmware_status()

Vishal Verma (5):
      ndctl/test: Fix region selection in align.sh
      ndctl/test: fix align.sh to not expect initialized labels
      ndctl/README: Add CONFIG_ENCRYPTED_KEYS to the config items list
      ndctl/namespace: fix a resource leak in file_write_infoblock()
      ndctl/lib: fix new symbol location in the symbol script
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
