Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE562AAAEB
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 13:18:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B898E1620F742;
	Sun,  8 Nov 2020 04:18:00 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83B181620F740
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 04:17:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id o129so5439622pfb.1
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 04:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNYicjtdNDGvF1yBZtQGVNAqZ+2jeghMMJ4KxvNaW5U=;
        b=Ev0eP9RVXzOdcEZTq2oiMcA+P64f4VRlTjReteeI2sKPs+Did1N9/VubsmCdx9OdDL
         ItdrY71g8IXbZUT9/l40kdEiylq8VyDcyejrY0umHRDYCRutYiQtYXu8JOQTBdIV+In0
         X6ZMR0583UGv9QAzgXe9e7/RhizAZS5GMex8jcmJERxL42YfN02F03Mlp5hO+qyALXJi
         dNTLVvwWgI90+3zRWEkkJiX3FvNrCxNoaiI+zdXZjivIDbiteWzgPnDADDL381ub7GsF
         6ZE8/z48JEFkwPq+hbQ209l8wTO1sPrvzN3Xc9vtUk51NlxVNXFY3KM6f4Ac1qC92pQ9
         dCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNYicjtdNDGvF1yBZtQGVNAqZ+2jeghMMJ4KxvNaW5U=;
        b=AXsr+Bs82aqp3+qknTfeNgvKLYfo+CAt0gCh/lnygY+YjME+VOAFRFZWMmI+rwuXb4
         2AaMmdiL/brTBlDzknQsxD7YsvXRiCF10YJ7nGF0kO6R/+0ljJVtooSZbECLO+GAI+bS
         i9KuUfJpRjawSwLw9MSgTn88apbGQ6fEE+ztAlO9lu2WGS899Lv3+hDxzmcL9/of5Otw
         +KTmZbX3GVvrWovIFdDTAnlEEuO63aEpbEIKnyoe0LnUH42cg5KA0wIt/Jo4x7Zc68KI
         3sZvXdqguFpRQnRnqo6nGdRenhrxdJKHwvYbctNcgMR7T4t23T4E9n00hys1wknd2pZH
         pjQw==
X-Gm-Message-State: AOAM533zB0S2JiUHWUiNboivJAz7Z/vOnD1J0wGtL70/v7l7eaW4BNsx
	F8sVhY3Dy523Uz0ujk5lzGLLsrP8px+dbg==
X-Google-Smtp-Source: ABdhPJwGR2Q2kaDPxdcC/Y7D83OuTHhVV3+PrB6VpbEjER6+xtTGaewbtdcdVUnGi9kU1ts5VmCT9Q==
X-Received: by 2002:a62:92c5:0:b029:156:6a7f:ccff with SMTP id o188-20020a6292c50000b02901566a7fccffmr9713773pfd.39.1604837875808;
        Sun, 08 Nov 2020 04:17:55 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id g1sm7668342pjl.33.2020.11.08.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 04:17:55 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v4 0/1] PMEM device emulation without nfit depenency
Date: Sun,  8 Nov 2020 17:47:22 +0530
Message-Id: <20201108121723.2089939-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: EUH7AK2ATXD2X3JXIPKKVPMIUH3X37B4
X-Message-ID-Hash: EUH7AK2ATXD2X3JXIPKKVPMIUH3X37B4
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EUH7AK2ATXD2X3JXIPKKVPMIUH3X37B4/>
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
Testsuite summary for ndctl 70.6.ge117f22                                              
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
Testsuite summary for ndctl 70.gite29f6c57
============================================================================
# TOTAL: 26
# PASS:  14
# SKIP:  3
# XFAIL: 0
# FAIL:  9
# XPASS: 0                                  
# ERROR: 0

Error injection tests and SMART are not yet implemented. To run the tests disable
CONFIG_ACPI_NFIT, the kernel will pick the new driver.

Santosh Sivaraj (1):
  testing/nvdimm: Add test module for non-nfit platforms

 drivers/nvdimm/region_devs.c        |    5 +
 tools/testing/nvdimm/config_check.c |    3 +-
 tools/testing/nvdimm/test/Kbuild    |    6 +-
 tools/testing/nvdimm/test/ndtest.c  | 1174 +++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |   84 ++
 5 files changed, 1270 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
