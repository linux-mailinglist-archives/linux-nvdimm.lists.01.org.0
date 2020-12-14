Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A92D9667
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:39:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4E59100EF264;
	Mon, 14 Dec 2020 02:39:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27FC0100EF24F
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id bj5so8422450plb.4
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQB/PleexOKrdVCSi3B8OPHhpneIwhJ61de0qzJ96N8=;
        b=bACoKyJGXoi1vamsFPLNbZYqKi/IFz6DXprG2qZLD9muT3JROLrpUmedNnmV3NCk/S
         Smde+DO3YlDJp2h04pcP0oQJ+0eYEMVFXBz+3g44i6nX+xJTNSrXo1ebieVaggTcBge9
         lz8qN23bEHsma7sXO2V8BXSB3fLkwj7S9QyRXv+KaM5ZLrnvwTq/oHrvp8yVFxTQ/s22
         g47suYKpzKWogZIuTHVxWgyohx4hkf/NDCfMRe8NVHlQM21SM5NSU0oI/CFrgJ0XM/Z3
         LUXtYQo3kREn4NzUjB5kr2TmQ8c0reXTre7KCA8pzsipaTU2VTsQ4SisxhHWfQE3J7OY
         yhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQB/PleexOKrdVCSi3B8OPHhpneIwhJ61de0qzJ96N8=;
        b=Y1c9lCK5eM3kRNXXeFu3GKuEJ6kBoUnVvtO86aNV7WnhwELkMAwq06n+qBgoWdGQMJ
         aCGDizfYjj/QfyBAOZ2DvMHxbTQrJLlho4c0DCn2HluOKb7JqGKjOtHURsPHZSfO9DbF
         fc/ugl4bCCdcmmLeSTuvhJRE/CYAsfAJ5zmaOMRXlODBR0DWXC3Sy+QA+ZtOPUguIj0m
         hfD68Z83D+lxR3aqje3hWOWjDte5PvbD4fMYqMdWe2Br7D0J18Tn43hnmGoBqIf6YSdt
         D20vKb+/dLbu0uR3yHCDyp3InVmDYXnPHhy5X+lnHGWQwp8CPzWkdGSvxq7zFowM2Go7
         O94g==
X-Gm-Message-State: AOAM532ZOMzF0qzcUftZfT80JksA8HqDynxJUR+ApW1pSw/U+ek8hZjn
	aCaV6xIhEF5v6SSwep7r2kKtX6g6zoHhJQ==
X-Google-Smtp-Source: ABdhPJwqLCjo2AHOfrCqX4zwIs87LZxQ2M8EUzH8zoWsa9F73iaSYtrLhNwQzhGF96t61pjOz95EnQ==
X-Received: by 2002:a17:90a:1b29:: with SMTP id q38mr24664856pjq.223.1607942362419;
        Mon, 14 Dec 2020 02:39:22 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id p1sm20735926pfb.208.2020.12.14.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:39:21 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v5 0/7] PMEM device emulation without nfit depenency
Date: Mon, 14 Dec 2020 16:08:52 +0530
Message-Id: <20201214103859.2409175-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: VYLZABI4M4XGXJEAKYMY475EXSW43FTA
X-Message-ID-Hash: VYLZABI4M4XGXJEAKYMY475EXSW43FTA
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VYLZABI4M4XGXJEAKYMY475EXSW43FTA/>
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

The following is the test result, run on a x86 guest:

PASS: libndctl                                                                         
PASS: dsm-fail                                                                         
PASS: dpa-alloc                                                                        
PASS: parent-uuid                                                                      
PASS: multi-pmem                                                                       
PASS: create.sh                                                                        
FAIL: clear.sh                                                                         
FAIL: pmem-errors.sh                                                                   
FAIL: daxdev-errors.sh                                                                 
PASS: multi-dax.sh                                                                     
PASS: btt-check.sh                                                                     
FAIL: label-compat.sh                      
PASS: blk-exhaust.sh                       
PASS: sector-mode.sh                       
FAIL: inject-error.sh                      
SKIP: btt-errors.sh                        
PASS: hugetlb                              
PASS: btt-pad-compat.sh                                                                
SKIP: firmware-update.sh                                                               
FAIL: ack-shutdown-count-set                                                           
PASS: rescan-partitions.sh                                                             
FAIL: inject-smart.sh                      
FAIL: monitor.sh                           
PASS: max_available_extent_ns.sh                                                       
FAIL: pfn-meta-errors.sh                                                               
PASS: track-uuid.sh                        
============================================================================
Testsuite summary for ndctl 70.10.g7ecd11c                                              
============================================================================
# TOTAL: 26                                
# PASS:  15                                
# SKIP:  2                                 
# XFAIL: 0                                 
# FAIL:  9                                 
# XPASS: 0                                 
# ERROR: 0

The following is the test result from a PowerPC 64 guest.

PASS: libndctl
PASS: dsm-fail
PASS: dpa-alloc
PASS: parent-uuid
PASS: multi-pmem
PASS: create.sh
FAIL: clear.sh
FAIL: pmem-errors.sh
FAIL: daxdev-errors.sh
PASS: multi-dax.sh
PASS: btt-check.sh
FAIL: label-compat.sh
PASS: blk-exhaust.sh
PASS: sector-mode.sh
FAIL: inject-error.sh                       
SKIP: btt-errors.sh
SKIP: hugetlb
PASS: btt-pad-compat.sh
SKIP: firmware-update.sh
FAIL: ack-shutdown-count-set
PASS: rescan-partitions.sh
FAIL: inject-smart.sh
FAIL: monitor.sh
PASS: max_available_extent_ns.sh
FAIL: pfn-meta-errors.sh
PASS: track-uuid.sh
============================================================================  
Testsuite summary for ndctl 70.git94a00679
============================================================================
# TOTAL: 26
# PASS:  14
# SKIP:  3
# XFAIL: 0
# FAIL:  9
# XPASS: 0                                  
# ERROR: 0

Error injection tests and SMART are not yet implemented.

Changes from V4:
- Split the driver patches into smaller chunks for ease of review
- [ndctl] Adding dimm attributes for nfit and papr, make it into one function [Dan]
- [ndctl] If nfit modules are missing, check for acpi support before failing, slightly
  different approach   than what Dan commented.

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
