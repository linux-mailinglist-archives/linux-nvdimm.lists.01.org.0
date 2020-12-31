Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9702E8100
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Dec 2020 16:36:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43D05100EC1F1;
	Thu, 31 Dec 2020 07:36:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=meyster.artur@careerkarma.co; receiver=<UNKNOWN> 
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5978F100EF265
	for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 07:36:09 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id k78so17625951ybf.12
        for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 07:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=careerkarma.co; s=google;
        h=from:mime-version:date:message-id:subject:to;
        bh=aK08k/UWu4qZ7ZAlEApSqMUwzLpOqO/KUJy2TDxoVq0=;
        b=UxXDlQW9FKkaEDr9LGK/iChAFraPLoTUDykhZWB6zBeEyWMcBBv1bzosawVC075kpB
         DYUMW5S1hhop7H5f+ntY+eT9EKyL2oTs/U+6NHlQVSh32Zyk81fde50E6t0N7j2Wz4tt
         JjTr/BsLvy/tcECw8SXSpKODYO46Qai7uhjdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=aK08k/UWu4qZ7ZAlEApSqMUwzLpOqO/KUJy2TDxoVq0=;
        b=jfRUL3Mf50Ei6WI8QTPU146y2vJzw7995hA5dPpWs8BM4ENjhJZN6aQaHHdlP4hUiY
         UAdYMPgzjnjHwMmaZJr0oeS9/J0QE4DQLODiq7HjrRnV/J5L7ixJmCQKI5sg9Jub2NOZ
         61TMtUuk9AMdB4aUzgBMeDoxIJ151qG+UWkTguDNSXebobY/KJJ+ClLd0zU8MNpJnlOk
         i7NKGh8JI3i1DY4mxS8tBkdw12uK6ncTwlvdX7d3woapEnb/5m2IJraI5g/lt9fm6/yp
         dNYgAAkn1kfFS4FvYw8CcG8gL7IGADG4lPZlzhDpWEKlGXq7Jg4djbXnLfOTkCrGjURd
         7q3w==
X-Gm-Message-State: AOAM533o5SnTAuAJz4FgBxsCTiF2be1yi2LcQ0ZAxbsEjvH1aBV9q6Li
	3eY2V92aOt2YLq1MBjRGtJJ/IssokRM+fKKHoQE8MPAHKT0=
X-Google-Smtp-Source: ABdhPJwRK02AyFdMexxqR34yMJepQdxHX9gWp6eZrXFU5+OSaQ+Ps450SsPpDcImzzOZuuLXaf4q7NvaLQGzERddS5Q=
X-Received: by 2002:a5b:d11:: with SMTP id y17mr7713361ybp.414.1609428967908;
 Thu, 31 Dec 2020 07:36:07 -0800 (PST)
Received: from 1036669786545 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 31 Dec 2020 07:36:07 -0800
From: Artur Meyster <meyster.artur@careerkarma.co>
Mime-Version: 1.0
Date: Thu, 31 Dec 2020 07:36:07 -0800
Message-ID: <CADo9yaAMBy93Syq0csWiO9eyb4LnOOQuk4Whna9vq_byd-xr-g@mail.gmail.com>
Subject: Are You Open to Collaborating on Content?
To: linux-nvdimm@lists.01.org
Message-ID-Hash: DXP6ZTI2AEMVBFALPF6T3VY7BLMMVBWU
X-Message-ID-Hash: DXP6ZTI2AEMVBFALPF6T3VY7BLMMVBWU
X-MailFrom: meyster.artur@careerkarma.co
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DXP6ZTI2AEMVBFALPF6T3VY7BLMMVBWU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi - I was surfing lists.01.org and I really liked your content strategy.

I'm the founder of BootcampRankings and Career Karma, where we are
passionate about helping people switch careers and learn new skills. I
think this is especially relevant now with thousands of people losing their
jobs due to COVID.

I was wondering if I can submit a high-quality original blog post (no
cost), that's never been published anywhere else, to be featured on your
site?

*Here's a list of possible topics:*
1) How remote work is changing tech salaries in the era of coronavirus
2) How to Know if your current career isn't right for you
3) What to do if you lost your job because of COVID-19
4) The future of work: are your skills up to date?
5) How new technologies are disrupting incumbent industries
6) The most resilient jobs during COVID-19
7) How to hire and retain tech talents
8) How COVID is impacting the education industry
9) What are the future trends for the education industry

(Or you can share a topic or field you are interested in.)

*And here are a few of our recent posts:*
https://www.aithority.com/guest-authors/how-regular-people-are-breaking-into-tech-from-non-tech-jobs/
https://thefintechtimes.com/how-elon-musks-neuralink-could-reshape-entire-economies/
https://inkbotdesign.com/artificial-intelligence-in-design/

Again, really love your work.


Warmly,

Artur Meyster
Founder
<https://careerkarma.com/>LinkedIn <https://www.linkedin.com/in/meyster>

Click here
<https://h1.mltrk.io/unsubscribe/bEdReVdMblVOYThhc0ZFUzlaaG45NHdPUlp0bWFZVUpnb0ttN3VSc1licytySHRjNkIrVEh0Uk9sZEwralh3MzNjeEtGcmpZNGlMcXhNVG84OU5tWXpDUzB0eXVoWVR3NFBOVVM5S3pqS3RyVzJLMzVuUURIa2FEMlJLMHg4cVEtLTVqMlIvWmN2VjZWbDBuRDd2RmR1OUE9PQ==--745ea3b7edc5d9463837c3d05647ae528e3aeff5>
if you don't want to hear from me again.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
