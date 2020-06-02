Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDA1EC444
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 23:21:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36DD910117608;
	Tue,  2 Jun 2020 14:16:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EF2E10117603
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 14:16:30 -0700 (PDT)
IronPort-SDR: aOMM6Xqkt/fRWPCfn5a9oMhzSlLo6t1ub+F3CBwNlO4X2QaYTDPPwSRB9pmpvZcy9L3knPOS6t
 cbYjF5RNN9lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 14:21:23 -0700
IronPort-SDR: EEhUn07lmi4P8XEIms+7mISCZo6Hbipu2OAakqiDzCXegZjKU3IFYy+VS8AuKGL1yBiwXGfZhF
 J37NFW7669zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400";
   d="scan'208";a="257242816"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 14:21:23 -0700
Date: Tue, 2 Jun 2020 14:21:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [RESEND PATCH v9 1/5] powerpc: Document details on H_SCM_HEALTH
 hcall
Message-ID: <20200602212122.GB1676657@iweiny-DESK2.sc.intel.com>
References: <20200602101438.73929-1-vaibhav@linux.ibm.com>
 <20200602101438.73929-2-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602101438.73929-2-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: YAUVN5OTFYJSAZI35JKKYDNA263NUFZP
X-Message-ID-Hash: YAUVN5OTFYJSAZI35JKKYDNA263NUFZP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YAUVN5OTFYJSAZI35JKKYDNA263NUFZP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 02, 2020 at 03:44:34PM +0530, Vaibhav Jain wrote:
> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
> specification.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>

Acked-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> Resend:
> * None
> 
> v8..v9:
> * s/SCM/PMEM device. [ Dan Williams, Aneesh ]
> 
> v7..v8:
> * Added a clarification on bit-ordering of Health Bitmap
> 
> Resend:
> * None
> 
> v6..v7:
> * None
> 
> v5..v6:
> * New patch in the series
> ---
>  Documentation/powerpc/papr_hcalls.rst | 46 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
> index 3493631a60f8..48fcf1255a33 100644
> --- a/Documentation/powerpc/papr_hcalls.rst
> +++ b/Documentation/powerpc/papr_hcalls.rst
> @@ -220,13 +220,51 @@ from the LPAR memory.
>  **H_SCM_HEALTH**
>  
>  | Input: drcIndex
> -| Out: *health-bitmap, health-bit-valid-bitmap*
> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>  
>  Given a DRC Index return the info on predictive failure and overall health of
> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
> -valid.
> +the PMEM device. The asserted bits in the health-bitmap indicate one or more states
> +(described in table below) of the PMEM device and health-bit-valid-bitmap indicate
> +which bits in health-bitmap are valid. The bits are reported in
> +reverse bit ordering for example a value of 0xC400000000000000
> +indicates bits 0, 1, and 5 are valid.
> +
> +Health Bitmap Flags:
> +
> ++------+-----------------------------------------------------------------------+
> +|  Bit |               Definition                                              |
> ++======+=======================================================================+
> +|  00  | PMEM device is unable to persist memory contents.                     |
> +|      | If the system is powered down, nothing will be saved.                 |
> ++------+-----------------------------------------------------------------------+
> +|  01  | PMEM device failed to persist memory contents. Either contents were   |
> +|      | not saved successfully on power down or were not restored properly on |
> +|      | power up.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  02  | PMEM device contents are persisted from previous IPL. The data from   |
> +|      | the last boot were successfully restored.                             |
> ++------+-----------------------------------------------------------------------+
> +|  03  | PMEM device contents are not persisted from previous IPL. There was no|
> +|      | data to restore from the last boot.                                   |
> ++------+-----------------------------------------------------------------------+
> +|  04  | PMEM device memory life remaining is critically low                   |
> ++------+-----------------------------------------------------------------------+
> +|  05  | PMEM device will be garded off next IPL due to failure                |
> ++------+-----------------------------------------------------------------------+
> +|  06  | PMEM device contents cannot persist due to current platform health    |
> +|      | status. A hardware failure may prevent data from being saved or       |
> +|      | restored.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  07  | PMEM device is unable to persist memory contents in certain conditions|
> ++------+-----------------------------------------------------------------------+
> +|  08  | PMEM device is encrypted                                              |
> ++------+-----------------------------------------------------------------------+
> +|  09  | PMEM device has successfully completed a requested erase or secure    |
> +|      | erase procedure.                                                      |
> ++------+-----------------------------------------------------------------------+
> +|10:63 | Reserved / Unused                                                     |
> ++------+-----------------------------------------------------------------------+
>  
>  **H_SCM_PERFORMANCE_STATS**
>  
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
