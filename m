Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC343B114E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 16:42:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19B22202E6DE3;
	Thu, 12 Sep 2019 07:42:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5DA61202E2938
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:42:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r22so8274799lfm.1
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5YVmroOmWsfbPZww9PGat/bavCeNmvQGcimrBhWBuy4=;
 b=K76FKy6ESnqOvkBCMCo6qwFBykl2HdgaTHRY3YvD94OEdMgn9uYrY/t3Kmifp0e0uD
 LKnNGAwBNrnpdLtTq9Y4/2qsIRatfXp4eGFn0qSiJZTHqhBN8a91HDkxHp/U7w44lQq9
 v1ggR0KcIzhSI+0MbaLJSfH2FWbpjSsGKPCyd2dAWcg9hKLHNSh5LIzcI74Gjc+/Ldyq
 saKzYeh0F20mLAZa06YrBLvngFBnrnuKNU7eq7UERSVLSk9yPQ6sz5lNpPe55yuHx61l
 ffgqplJqtREYfZa6YR5FZdkdKY3CFo9akYzMw+XUp0ASe2YSHqJL0Hitx9EuJrKhvtlr
 reVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5YVmroOmWsfbPZww9PGat/bavCeNmvQGcimrBhWBuy4=;
 b=b5efSO9gN0UvtD4q+VyAaGEh1nAl4kgGpCiAtK2M2WdQXzAyKKr1pnJIMDbQCHZbZ7
 01epDki3N51Edvjzel9gccNP45wcmWQ8n/ofieD4bUOHZzvobhOiE5M+LpRgxJEosPR1
 67oEl0/HkKKhqdi2ttN5Y0SfVMVtb47k1CKDw22DLuGk19GjatFBqvl1iTaiIuTdTl21
 iLOwtz3ljS5uJYkUWN3pGca8jJWZtkZXw0xGuT9ga/ldN6N/kmjGc8wz5fRgVJQzVe1G
 8Up88lsn93Jy56wVRBc6mP+UF3GbZkbApi/lIrJRaiTAnOx5NBQp8je8DH/KkvU8o0vJ
 xYWw==
X-Gm-Message-State: APjAAAX3fNAJMEi3Q3NiPr0qwT7zfnJPgVx0blYGpcW6o3SZ7d3y3h4W
 YseLBWA51tbs4EIij/yHCfpn9nR3w+RIQni1uyM=
X-Google-Smtp-Source: APXvYqy5v3NkZEjEMM7AwjSVopo8j9FGoJxzUq1NdqYhh5e1x0kmCJH4LPdki4NmHpjeLat+4zGNy30KUDyElmgw5l0=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr2286425lfl.131.1568299334764; 
 Thu, 12 Sep 2019 07:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
 <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
In-Reply-To: <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Sep 2019 16:42:03 +0200
Message-ID: <CANiq72ntjDRyMBdVXLMV9h=3_jU47UA06LaGvR2Jw9aMZM3V3w@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Joe Perches <joe@perches.com>
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
Cc: Jens Axboe <axboe@kernel.dk>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 12:18 PM Joe Perches <joe@perches.com> wrote:
>
> I don't think that's close to true yet for clang-format.

I don't expect clang-format to match perfectly our current code style.

However, if core maintainers agree that it is "close enough now"
(specially with newer LLVMs, like 9), then there is a great benefit on
moving to automatically-styled code. The "con" is having to change a
bit our style wherever clang-format does not support exactly our
current style.

> For instance: clang-format does not do anything with
> missing braces, or coalescing multi-part strings,
> or any number of other nominal coding style defects
> like all the for_each macros, aligning or not aligning
> columnar contents appropriately, etc...

Some of these may or may not be fixable tweaking the options. Note
that there are conflicting styles within the kernel at the moment,
e.g. how to indent arguments to function calls. Therefore, some of the
differences do not apply as soon as we decide on a given style.

Furthermore, with automatic formatting we have also the chance to
review some options that we couldn't easily change before.

> clang-format as yet has no taste.
>
> I believe it'll take a lot of work to improve it to a point
> where its formatting is acceptable and appropriate.
>
> An AI rather than a table based system like clang-format is
> more likely to be a real solution, but training that AI
> isn't a thing that I want to do.

I don't think we need taste (or AI-like solutions), because
consistency has a lot of value too. Not just for our brains, but for
patches as well.

Note that clang-format is a tool used by major projects successfully,
it is not like we are experimenting too much here :-)

Cheers,
Miguel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
