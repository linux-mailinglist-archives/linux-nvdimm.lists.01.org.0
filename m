Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B5A35FD40
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 23:24:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18ADF100EB32F;
	Wed, 14 Apr 2021 14:24:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0957100EC1D9
	for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 14:24:18 -0700 (PDT)
IronPort-SDR: /0uDIOZE9agyC9MHC0sBvB47wnBXUpZsUriOAkDQkaMqMY+FvS51EvDeKPq/5wuHloJDIr0+1t
 Lur6Yd9cOkcg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="182241444"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400";
   d="scan'208";a="182241444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 14:24:17 -0700
IronPort-SDR: OQisyYjSRzHMWbR1sr/zXCDxGy72+URmxBOoD1fbM+AL9NfJQcgg2I0UHNQN18pC0s0enQ9zW4
 HhdrOg8+GkbQ==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400";
   d="scan'208";a="522128834"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 14:24:17 -0700
Date: Wed, 14 Apr 2021 14:24:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats
 inaccessible
Message-ID: <20210414212417.GC1904484@iweiny-DESK2.sc.intel.com>
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
 <20210414153625.GB1904484@iweiny-DESK2.sc.intel.com>
 <87lf9kkfaj.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lf9kkfaj.fsf@vajain21.in.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: Q45AOUTKGMRTFMPYPQS5XVHSYLRTHOQP
X-Message-ID-Hash: Q45AOUTKGMRTFMPYPQS5XVHSYLRTHOQP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q45AOUTKGMRTFMPYPQS5XVHSYLRTHOQP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 14, 2021 at 09:51:40PM +0530, Vaibhav Jain wrote:
> Thanks for looking into this patch Ira,
> 
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > On Wed, Apr 14, 2021 at 06:10:26PM +0530, Vaibhav Jain wrote:
> >> Currently drc_pmem_qeury_stats() generates a dev_err in case
> >> "Enable Performance Information Collection" feature is disabled from
> >> HMC. The error is of the form below:
> >> 
> >> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> >> 	 performance stats, Err:-10
> >> 
> >> This error message confuses users as it implies a possible problem
> >> with the nvdimm even though its due to a disabled feature.
> >> 
> >> So we fix this by explicitly handling the H_AUTHORITY error from the
> >> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
> >> error, saying that "Performance stats in-accessible".
> >> 
> >> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> >> index 835163f54244..9216424f8be3 100644
> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
> >>  		dev_err(&p->pdev->dev,
> >>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
> >>  		return -ENOENT;
> >> +	} else if (rc == H_AUTHORITY) {
> >> +		dev_warn(&p->pdev->dev, "Performance stats in-accessible");
> >> +		return -EPERM;
> >
> > Is this because of a disabled feature or because of permissions?
> 
> Its because of a disabled feature that revokes permission for a guest to
> retrieve performance statistics.
> 
> The feature is called "Enable Performance Information Collection" and
> once disabled the hcall H_SCM_PERFORMANCE_STATS returns an error
> H_AUTHORITY indicating that the guest doesn't have permission to retrieve
> performance statistics.

In that case would it be appropriate to have the error message indicate a
permission issue?

Something like 'permission denied'?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
