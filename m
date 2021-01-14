Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F82F5ABC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 07:30:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEA9D100F2265;
	Wed, 13 Jan 2021 22:30:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F46C100EB35A
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 22:30:14 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 861DDAB92;
	Thu, 14 Jan 2021 06:30:12 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 14 Jan 2021 07:30:11 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in soft_offline_page()
In-Reply-To: <CAPcyv4gVPMUD7P0KwAY9xk3xBkodPExeJVG6i9=9FGexbJZpBw@mail.gmail.com>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210114014944.GA16873@hori.linux.bs1.fc.nec.co.jp>
 <CAPcyv4gVPMUD7P0KwAY9xk3xBkodPExeJVG6i9=9FGexbJZpBw@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <c470b3d344e560e5c1c7b57f9bf83a37@suse.de>
X-Sender: osalvador@suse.de
Message-ID-Hash: EOMVLFENY3DLF3BZ3QSZSCBRGVY63NEC
X-Message-ID-Hash: EOMVLFENY3DLF3BZ3QSZSCBRGVY63NEC
X-MailFrom: osalvador@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3_=E7=9B=B4=E4=B9=9F=29?= <naoya.horiguchi@nec.com>, akpm@linux-foundation.org, Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EOMVLFENY3DLF3BZ3QSZSCBRGVY63NEC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2021-01-14 07:18, Dan Williams wrote:
> To be honest I dislike the entire flags based scheme for communicating
> the fact that page reference obtained by madvise needs to be dropped
> later. I'd rather pass a non-NULL 'struct page *' than redo
> pfn_to_page() conversions in the leaf functions, but that's a much
> larger change.

We tried to remove that flag in the past but for different reasons.
I will have another look to see what can be done.

Thanks

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
