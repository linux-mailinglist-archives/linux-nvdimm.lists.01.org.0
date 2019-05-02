Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3912416
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 23:25:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6668212449E9;
	Thu,  2 May 2019 14:25:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 41D8E2194EB76
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 14:25:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g57so3492597edc.12
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oqcKatM0uGeQ3Db2t4iHmyuMiU+/ILY+eE3Km3ykIKY=;
 b=AgY5AF+e2le1uHZ3YDirUDNp1TICE3KTNFAqpOvtdLkS6yP1eLKWPoHzGo8y9rmtXP
 W5zYcv98aBbZRyN6WhuuD5cQ5xqFsd7QAANcsN+hKVdl2kYcFm3t/jFqXFnaBJcd2GsR
 XSH+++y4C9Te7uKfEGbSKMFWD0QzFyal9FhNZU8FNJcQpwO1Sh0atef843W+/TVcR2ur
 Xk+F4nnTDSgAxLXtTCOJZ5/rYr63SJP5+lF0QpnikjbrXj+LKIy42y1uDsDvKIN248Ih
 lEBjsaxOweTFgodUin00Y7YTcqWXk0wvSLTestHkzf9wEtJJoQGFzv9jnuBtRgOEJwFy
 o2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqcKatM0uGeQ3Db2t4iHmyuMiU+/ILY+eE3Km3ykIKY=;
 b=FPHw0AVWYFM1vLngVRDIa0op5HL/OAwsZHF+cNOTUB0UCcXIGBICXG6ZDqehOtVJh3
 QRyCbQoLEwSYTGTAkV8S3ejao91lv5j0X8xzro1sUq1G1tPAzvv5/6X8MzUz7zFtKxFA
 0RloCibURvGPUXB6G48xTlccIRWBmWqHk7rAVQ+75IdZtP26sSE9GhwrVvCEKzx8+wHx
 lMX7MHD2l2E1RfXdaVROwglKArHOv1vOqexHnyUhho5Ks+TNRyu2037DInidNurAlYFP
 A1GwOTge+yRSxKHRUZY0yoQdyzgekk7R6dMDOcqyYqTFln4Ah8KGuACSHW9SEJd8Wf68
 DhAg==
X-Gm-Message-State: APjAAAXid51ZzZdvA7+uRpZxhPTnVVzRCWRAyfcONZ2nYvMHzaD/YosD
 0Xt1g+m3ZeX9SO99WShGIVy1Ih1g6G4yGcBPPkcrCQ==
X-Google-Smtp-Source: APXvYqw1VQMw7Xf/epk8qLnpcgvdR+kuprbmNMpiiIscKSKCrluznkQGvwnw3n2TtUh1xmbwidclePAglNL4CTqh4Pg=
X-Received: by 2002:a50:fb19:: with SMTP id d25mr4206716edq.61.1556832340698; 
 Thu, 02 May 2019 14:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552637717.2015392.6818206043460116960.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552637717.2015392.6818206043460116960.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 17:25:29 -0400
Message-ID: <CA+CK2bBY2KgLGsXJDhsZe3QV-871O07Yx+fvMwU2_zNNn+zjzA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] mm/sparsemem: Prepare for sub-section ranges
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
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Prepare the memory hot-{add,remove} paths for handling sub-section
> ranges by plumbing the starting page frame and number of pages being
> handled through arch_{add,remove}_memory() to
> sparse_{add,remove}_one_section().
>
> This is simply plumbing, small cleanups, and some identifier renames. No
> intended functional changes.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
