Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F32E0550
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C26FD100EBBC3;
	Mon, 21 Dec 2020 20:23:21 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46A5A100EBBC0
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so7721231pfu.4
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spLOBfaiHmHB1N7T7E12nEZUR0a7/HkW3UyWm2NitGw=;
        b=vtX3rLd+EGk9zJ1zNbz2vuRlNauhQMH+OC4JGRSKyU6VaYCqolOVu/mkhqGIgjZilS
         jNtw1GLgQ/Vc1sNxgDr2xQtGESuSlBp2HG7YFDvgJR0JVihvB6D7nB5/NkZECA57Tzfl
         QN0Wj8aHIDFYFoVF3MiC0fKI4XztvgbtX5Xv7exi4mWipGWZCkscSZYBISvcgQo9V+UG
         aM7Gm+9/YtUAv6Lqse2IcM2A8FOT5wPHwZhJT1g1HItbb9nRxM8NulqTPX3nBPeSTMY1
         CJBcW1SP/JIEx1ioE1b2VdM/UbJwlU22Bs1PCjY4I/2+biDb9+9XlfqdIkadsiBBKP40
         aWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spLOBfaiHmHB1N7T7E12nEZUR0a7/HkW3UyWm2NitGw=;
        b=N3oSWEvSLQjP9pFp7/VFR4yA2+KptYT/WWYAOFI3orRyJizWE2o9Hn/TbDZIYb+gBh
         ziN74kMm9FklzwlTWtyJePocOw8oSoQjywATocQASAZE2er2dC2O0De6mdmp+iWK9+OH
         FQHVUNH98sfSmSW3mnM4T716wh4B9LCSPbwYIuCG0HPNhCtY8MeFuXqD7e/cImWzBBnu
         OsyRiCiifb3mSBi7ORxKqjM6uF0JM8H2fkGTW0LQfKOwu8xOlxbOoOyMOV6koknXBRdm
         GIQlaujEbUv+GHKuI5uNUpQPbLllx62pGhd63yMvwk2thNH1yc8M3kJL1clFblmFIO/k
         b4nQ==
X-Gm-Message-State: AOAM530h/P2lhjO7pariNxMvOsLsFDp9Dq2vYCKjfqs+2HsrViATR3qv
	V5Q94jKzHvsnXDLqnDmTGJW259CrUBC/wQ==
X-Google-Smtp-Source: ABdhPJzQ4sCbbu/GQ2ubburSqtJV4Jb+HSR0TVAfecYzb5WzKF+sgQOeCfmOsAPnwly/VyxujF30Ow==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr18127749pgj.254.1608610998237;
        Mon, 21 Dec 2020 20:23:18 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:17 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [0/7] PMEM device emulation without nfit depenency
Date: Tue, 22 Dec 2020 09:52:33 +0530
Message-Id: <20201222042240.2983755-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: 7ZZX3RKQFW3ET757O7SHX72I3FZ4SHAT
X-Message-ID-Hash: 7ZZX3RKQFW3ET757O7SHX72I3FZ4SHAT
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7ZZX3RKQFW3ET757O7SHX72I3FZ4SHAT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current test module cannot be used for testing platforms (make check)
that do not have support for NFIT. In order to get the ndctl tests working,
we need a module which can emulate NVDIMM devices without relying on
ACPI/NFIT.

The emulated PMEM device is made part of the PAPR family.

Corresponding changes for ndctl is also required, to add attributes needed
for the test, which will be sent as a reply to this patch.

None of tests passed on PAPR before, now there are 16 test that pass. Error
injection tests and SMART are not yet implemented.

Santosh Sivaraj (7):
  testing/nvdimm: Add test module for non-nfit platforms
  ndtest: Add compatability string to treat it as PAPR family
  ndtest: Add dimms to the two buses
  ndtest: Add dimm attributes
  ndtest: Add regions and mappings to the test buses
  ndtest: Add nvdimm control functions
  ndtest: Add papr health related flags

 tools/testing/nvdimm/config_check.c |    3 +-
 tools/testing/nvdimm/test/Kbuild    |    6 +-
 tools/testing/nvdimm/test/ndtest.c  | 1138 +++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |  109 +++
 4 files changed, 1254 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
