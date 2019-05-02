Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538C12375
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 22:37:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C60D21243BDE;
	Thu,  2 May 2019 13:37:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C4BCB21237ACE
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 13:37:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e24so3387575edq.6
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gz5D/2IZBhXJoQXag9Fc8P8nFKA7bPD957oNqAWGLnI=;
 b=QZVO0YSdzfzmNkr8hsoJiK5rKpblzW2amWDf3n87XB8fhXoSn/0aPPhTGprY8sH432
 Z9X7TBXWCAenJ7hQ8icWnharyhUwgZ07H/pYlQ9TRdzVVXoWeYT8vhGH/fpmW48/UU1w
 fo/fFr2FjArozB9eIWYNn6qqw7kSEo5ExaZZTLUjW52JRwMc/0f2sCATYTBnkzex1s1m
 wNvW5yhMCcea5C0W1TxWewa5XQh2j91YM+6UmdwPmCFYonn26TtLe9INPuxY0Ofo/Wyb
 +B/lwdxoIwUp9M3BAOpE1x2CBVcQRXItCPqMojFeHF6BT1OS8dSHKenLwEW1jW/5Y8XA
 NsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gz5D/2IZBhXJoQXag9Fc8P8nFKA7bPD957oNqAWGLnI=;
 b=YV7XkPuVnApscVMmzOnUamFNIUW/X7f5M/N68cGmVqgO/eaAgyXLUoqQ6Gsr24q20y
 7poT2Tf0wO3pVNif6hQxnECpSca2tdeK2XfuI7ph1qJd86ew7LzHthpsV4KG67zJWqeb
 8xvgGrSPzer7HQ1pmFWap60qxSFmlkEYejhyP/qRq425xJTh1gWmF2t7mXO8LxbBUgGY
 E6RF2O/IiMJtqECurE8JH/OraMGHa6zH5DkHhQWMuf9nPEfXNF3gCEJLTS4SUaBiQ5Kn
 PW0tKfRKmMeUPLM3uDIZoXjHUnPDm+hBjn4ETkG23kJDWVrXmkxoJGMrEDpd1pNwFgwo
 3X9w==
X-Gm-Message-State: APjAAAWz4IULqyjkDC512f7eDZXDdRB6rJboyB7vtIaZYoytLJLjAK62
 I9nRtu2L/0oRWoucAEb8FoeVSNeCFnysAF7WDS3khg==
X-Google-Smtp-Source: APXvYqxm66I1vthEPriE60HFHxcqTEq91Ksjm4zQsKZ0Wv4hwE8siQJ3nxYgBpV3fsWjIk682fpK9nZBMPnTkHm0aS0=
X-Received: by 2002:a50:a951:: with SMTP id m17mr3830583edc.79.1556829441732; 
 Thu, 02 May 2019 13:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 16:37:11 -0400
Message-ID: <CA+CK2bCq1KvdqZA6=_=F4CAem0aPCLYWFvrMavjm5F1+h7MA+A@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] mm: Kill is_dev_zone() helper
To: Dan Williams <dan.j.williams@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Given there are no more usages of is_dev_zone() outside of 'ifdef
> CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
