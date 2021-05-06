Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE139374EBB
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 06:58:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F3B0100EB325;
	Wed,  5 May 2021 21:58:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0150100EB835
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 21:58:18 -0700 (PDT)
IronPort-SDR: QqKhTVNmrrkcpf7Qz2OnXu8N7l7QxzqfMlAKEN+X+cy3roBtKdFqAvTZ3v+A96A/Itlmsv3ZWL
 G6RvVo1iu3Zw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="262320410"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400";
   d="scan'208";a="262320410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:58:18 -0700
IronPort-SDR: EF+8N3LXcl59PTDiecfIj5KDpwG3f9jF/LViXUSOrhWkGtYqM8jSlfn2mr6B5jTXwGP6Lxp/L4
 GGknPeZgbUvA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400";
   d="scan'208";a="434161480"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:58:18 -0700
Date: Wed, 5 May 2021 21:58:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Reduce error severity if nvdimm
 stats inaccessible
Message-ID: <20210506045817.GF1068722@iweiny-DESK2.sc.intel.com>
References: <20210505191606.51666-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210505191606.51666-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 43TLCOSLUASWGT4JJB5QE6FBVYJQF6DE
X-Message-ID-Hash: 43TLCOSLUASWGT4JJB5QE6FBVYJQF6DE
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43TLCOSLUASWGT4JJB5QE6FBVYJQF6DE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 06, 2021 at 12:46:06AM +0530, Vaibhav Jain wrote:
> Currently drc_pmem_qeury_stats() generates a dev_err in case
> "Enable Performance Information Collection" feature is disabled from
> HMC or performance stats are not available for an nvdimm. The error is
> of the form below:
> 
> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> 	 performance stats, Err:-10
> 
> This error message confuses users as it implies a possible problem
> with the nvdimm even though its due to a disabled/unavailable
> feature. We fix this by explicitly handling the H_AUTHORITY and
> H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.
> 
> In case of H_AUTHORITY error an info message is logged instead of an
> error, saying that "Permission denied while accessing performance
> stats". Also '-EACCES' error is return instead of -EPERM.

I thought you clarified before that this was a permission issue.  So why change
the error to EACCES?

> 
> In case of H_UNSUPPORTED error we return a -EPERM error back from
> drc_pmem_query_stats() indicating that performance stats-query
> operation is not supported on this nvdimm.

EPERM seems wrong here too...  ENOTSUP?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
