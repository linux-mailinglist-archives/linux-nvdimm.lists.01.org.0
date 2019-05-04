Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099213B07
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 May 2019 17:56:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2B952125046B;
	Sat,  4 May 2019 08:56:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F28142124B939
 for <linux-nvdimm@lists.01.org>; Sat,  4 May 2019 08:56:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l25so9793762eda.9
 for <linux-nvdimm@lists.01.org>; Sat, 04 May 2019 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D/xUA4we+CfWIBMstY2ZZGUlR8dNMfA/8aG9kri4RSo=;
 b=ZrdWTpIgvvrF424jIp+wrwRFjns9Vws1VhvhVyeQLQ8yUB0K/RtorMBF6hIJ8qdZr/
 EMNY9XodjCnuUSks5vvIic5f25dogm0UqOVLHW1qPGEa5AIPjIUxhdJ6vyyG+zQwjSVb
 Es6EOhcjogmP+jv9TmQXzop3fT6A5kIYR4QdSUVCyYBPBKteqVQv+Mr+7uyZmdwuPuLX
 0XuWwnIzEw5utfKyj4eEzEOCUe+bSQvYbR0zp66AsLiLTgD/1mSrqF+0Fi72jzDJxuSU
 jUBy/A5BIp4B5w1mm3m2TYLN7uiDehFBdz/RSQ6Qku4HP2JVpf746kbtSaqqIkqt/mKN
 QUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D/xUA4we+CfWIBMstY2ZZGUlR8dNMfA/8aG9kri4RSo=;
 b=TrlWJfpFBOwTbnGVQ006HhgWxlKEbaQEjm+xhb0VFQ1UvrjVZ6caq/C2fny/3KrJnM
 XUvL91votleD2vvKff4O8EBFUQaYscRj8RHrGRReiOeubnPGfWTPTNVaXQQJRLlFZ4M+
 FlQmS2Cbij/VOpuXlaaXdP7b8lpX5LOGr4HJs/nASXoM7Q5blj+YRKi6as8Zt9GSu8Uw
 2sQF0zRc2ztfTFM6BadEpDs3TUuujzqvDmPX7eSAQbMIFkL8+XcozxkaxNQZW7BdRdXz
 cUg5/JPekHqAM/c95z/GITh5/ED3GwYfPn8cqFLuvynaoaOgqObO2yVIS1r5mZPyLk8w
 Xt3g==
X-Gm-Message-State: APjAAAVZIcbQt+Ybq+co9KWdWRy3veHpUC3DVx0fuLg/evnbaoa5tNuA
 H0SIpaXkOzYvW5OyYtqc/c9e6wMS1s9+HuQVcdj5Ow==
X-Google-Smtp-Source: APXvYqwL1+OT6I7xDELCdfNz+oPiiC/N2OEv5oobeObUVGp+lISzqLMPEiMy5oB5eqPGvxPFUEwyNJ8Pi/qnMyQIUAw=
X-Received: by 2002:a17:906:3fca:: with SMTP id
 k10mr11517604ejj.126.1556985361722; 
 Sat, 04 May 2019 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
 <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
In-Reply-To: <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 4 May 2019 11:55:50 -0400
Message-ID: <CA+CK2bCVAuYFFee+P09H_5fN4w2BHXUS1ZeSVN7hxcCTwgobqA@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
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
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> > I'm ok with it being 16M for now unless it causes a problem in
> > practice, i.e. something like the minimum hardware mapping alignment
> > for physical memory being less than 16M.
>
> On second thought, arbitrary differences across architectures is a bit
> sad. The most common nvdimm namespace alignment granularity is
> PMD_SIZE, so perhaps the default sub-section size should try to match
> that default.

I think that even if you keep it 16M for now, at very least you should
make the map_active bitmap scalable so it will be possible to change
as required later without revisiting all functions that use it. Making
it a static array won't slowdown x86, as it will be still a single
64-bit word on x86.

Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
