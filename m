Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43043626F3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 19:36:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 814C9100EAB6E;
	Fri, 16 Apr 2021 10:36:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B853100EAB69
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 10:36:17 -0700 (PDT)
IronPort-SDR: AwMF4GzyBRJ2QWM1Z26zUAd+jnIiJK6qJw059Bj7voCvzYuk/fiopHWSuHwGbdgtkVYU3FUlvb
 k0Ys9E3GzUCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="259033311"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400";
   d="scan'208";a="259033311"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:36:14 -0700
IronPort-SDR: /G8uWyJoqpYxFkZQD8VLD5Dqg8KkxE+HRNc5pUt16jLXo3D9rjLp7z4QNfAQZgV6fimW794iI4
 VbkG1qA30tNg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400";
   d="scan'208";a="522771315"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:36:13 -0700
Received: from andy by smile with local (Exim 4.94)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1lXSO2-004iS7-PW; Fri, 16 Apr 2021 20:36:10 +0300
Date: Fri, 16 Apr 2021 20:36:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Message-ID: <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: PEEFCWCF5YI3CKRQQJTPZTMG5TDQQSJE
X-Message-ID-Hash: PEEFCWCF5YI3CKRQQJTPZTMG5TDQQSJE
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PEEFCWCF5YI3CKRQQJTPZTMG5TDQQSJE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> Strictly speaking the comparison between guid_t and raw buffer
> is not correct. Return to plain memcmp() since the data structures
> haven't changed to use uuid_t / guid_t the current state of affairs
> is inconsistent. Either it should be changed altogether or left
> as is.

Dan, please review this one as well. I think here you may agree with me.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
