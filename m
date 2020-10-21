Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF8295121
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Oct 2020 18:52:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E598115F38501;
	Wed, 21 Oct 2020 09:52:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CE5015F384FF
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 09:52:22 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 6AEDDAE7D;
	Wed, 21 Oct 2020 16:52:20 +0000 (UTC)
Date: Wed, 21 Oct 2020 18:52:18 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [RFC PATCH 0/4] powerpc/papr_scm: Add support for reporting
 NVDIMM performance statistics
Message-ID: <20201021165218.GO29778@kitsune.suse.cz>
References: <20200518110814.145644-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518110814.145644-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: YYST6ZKZ3F6DK2FZHF3D6MIZT5YI7W44
X-Message-ID-Hash: YYST6ZKZ3F6DK2FZHF3D6MIZT5YI7W44
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YYST6ZKZ3F6DK2FZHF3D6MIZT5YI7W44/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

apparently this has not received any (public) comments.

Maybe resend without the RFC status?

Clearly the kernel interface must be defined first, and then ndctl can
follow and make use of it.

Thanks

Michal

On Mon, May 18, 2020 at 04:38:10PM +0530, Vaibhav Jain wrote:
> The patch-set proposes to add support for fetching and reporting
> performance statistics for PAPR compliant NVDIMMs as described in
> documentation for H_SCM_PERFORMANCE_STATS hcall Ref[1]. The patch-set
> also implements mechanisms to expose NVDIMM performance stats via
> sysfs and newly introduced PDSMs[2] for libndctl.
> 
> This patch-set combined with corresponding ndctl and libndctl changes
> proposed at Ref[3] should enable user to fetch PAPR compliant NVDIMMs
> using following command:
> 
>  # ndctl list -D --stats
> [
>   {
>     "dev":"nmem0",
>     "stats":{
>       "Controller Reset Count":2,
>       "Controller Reset Elapsed Time":603331,
>       "Power-on Seconds":603931,
>       "Life Remaining":"100%",
>       "Critical Resource Utilization":"0%",
>       "Host Load Count":5781028,
>       "Host Store Count":8966800,
>       "Host Load Duration":975895365,
>       "Host Store Duration":716230690,
>       "Media Read Count":0,
>       "Media Write Count":6313,
>       "Media Read Duration":0,
>       "Media Write Duration":9679615,
>       "Cache Read Hit Count":5781028,
>       "Cache Write Hit Count":8442479,
>       "Fast Write Count":8969912
>     }
>   }
> ]
> 
> The patchset is dependent on existing patch-set "[PATCH v7 0/5]
> powerpc/papr_scm: Add support for reporting nvdimm health" available
> at Ref[2] that adds support for reporting PAPR compliant NVDIMMs in
> 'papr_scm' kernel module.
> 
> Structure of the patch-set
> ==========================
> 
> The patch-set starts with implementing functionality in papr_scm
> module to issue H_SCM_PERFORMANCE_STATS hcall, fetch & parse dimm
> performance stats and exposing them as a PAPR specific libnvdimm
> attribute named 'perf_stats'
> 
> Patch-2 introduces a new PDSM named FETCH_PERF_STATS that can be
> issued by libndctl asking papr_scm to issue the
> H_SCM_PERFORMANCE_STATS hcall using helpers introduced earlier and
> storing the results in a dimm specific perf-stats-buffer.
> 
> Patch-3 introduces a new PDSM named READ_PERF_STATS that can be
> issued by libndctl to read the perf-stats-buffer in an incremental
> manner to workaround the 256-bytes envelop limitation of libnvdimm.
> 
> Finally Patch-4 introduces a new PDSM named GET_PERF_STAT that can be
> issued by libndctl to read values of a specific NVDIMM performance
> stat like "Life Remaining".
> 
> References
> ==========
> [1] Documentation/powerpc/papr_hcals.rst
> 
> [2] https://lore.kernel.org/linux-nvdimm/20200508104922.72565-1-vaibhav@linux.ibm.com/
> 
> [3] https://github.com/vaibhav92/ndctl/tree/papr_scm_stats_v1
> 
> Vaibhav Jain (4):
>   powerpc/papr_scm: Fetch nvdimm performance stats from PHYP
>   powerpc/papr_scm: Add support for PAPR_SCM_PDSM_FETCH_PERF_STATS
>   powerpc/papr_scm: Implement support for PAPR_SCM_PDSM_READ_PERF_STATS
>   powerpc/papr_scm: Add support for PDSM GET_PERF_STAT
> 
>  Documentation/ABI/testing/sysfs-bus-papr-scm  |  27 ++
>  arch/powerpc/include/uapi/asm/papr_scm_pdsm.h |  60 +++
>  arch/powerpc/platforms/pseries/papr_scm.c     | 391 ++++++++++++++++++
>  3 files changed, 478 insertions(+)
> 
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
