Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8F2F95B7
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Jan 2021 23:01:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03039100EC1F9;
	Sun, 17 Jan 2021 14:01:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A6FD7100EC1F2
	for <linux-nvdimm@lists.01.org>; Sun, 17 Jan 2021 14:01:44 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A339920770;
	Sun, 17 Jan 2021 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1610920904;
	bh=syw3C+yi+MfIAsKsarxDn5CIv+WBNQ1M+WvC9IOMFT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z9UWtErkwTPaE9iJ/e6FJXucATo+qe58tJGsr8k3lobCCopZfYhtGyFtBlcooJR7H
	 3MNfOmc3VwhSLYyHiIWqsJ8vJTqMAsaQUBlVrAdJazF72qPbFcDQ38Z9sMFPZD+1q2
	 ifjtpfMSbB3+cIjwdZ27dFCJ6CcO9Jqk8nbC1GNU=
Date: Sun, 17 Jan 2021 14:01:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in
 soft_offline_page()
Message-Id: <20210117140142.ab91797266e0bef6b7dba9f9@linux-foundation.org>
In-Reply-To: <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
	<161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: PEL7LHXTWEA6DGDDYRF4QSSKSVQD5762
X-Message-ID-Hash: PEL7LHXTWEA6DGDDYRF4QSSKSVQD5762
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PEL7LHXTWEA6DGDDYRF4QSSKSVQD5762/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 13 Jan 2021 16:43:32 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> The conversion to move pfn_to_online_page() internal to
> soft_offline_page() missed that the get_user_pages() reference taken by
> the madvise() path needs to be dropped when pfn_to_online_page() fails.
> Note the direct sysfs-path to soft_offline_page() does not perform a
> get_user_pages() lookup.
> 
> When soft_offline_page() is handed a pfn_valid() &&
> !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
> a leaked reference.
> 
> Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A cc:stable patch in the middle is awkward.  I'll make this a
standalone patch for merging into mainline soon (for 5.11) and shall
turn the rest into a 4-patch series, OK?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
