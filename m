Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A6DCE84
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 20:43:52 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB67B10FC6E5E;
	Fri, 18 Oct 2019 11:45:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A1D210FC6E5D
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:45:54 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 89so5778029oth.13
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7hSdgPfvwT/ILyoHXl6EmXRqHLkcBjnuGBU3J0Zak4=;
        b=fqt3ha2AQZkvJo41yJwLXY5DKPAUxF5iQvYKJtNY1HdiE8v5EBX4cuuKe34wgpoZ9G
         AeDj5waISeN0Ci5wnD+m0lZt6oWJ+JWnkI31jlugBT76aN8r1QFU4Y4d5TJ4uT74wzch
         3+GvR6ishoaym2QyB4dEoS1SJJQ5YlY3Xqjw0k6uF9TqsvDViuir+Aum0nK40w7QMFiA
         xPGUIs/0Eqdagt7M4lJQzgxsxEL8oSsvrnhjnGD8haqbG4Suv5ALmh7IXRdakaxGS9XJ
         fFgGtEugX4ImZ7JhY77F9RaonMulcCNSscHikIElrQz1glo5ETMe4AdfC3x6RTUVBCZ/
         iRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7hSdgPfvwT/ILyoHXl6EmXRqHLkcBjnuGBU3J0Zak4=;
        b=bpzHNkxhWMbLuNDuXoe9ilKRBScatOfplw07f1VxZMWthLPGJhzXUH5NIJgGh/PV9E
         f3jrLLW/abrs8jIr9Ok2n+fiLPhs9gwG6m5xKUKpBdEcx1iXcrg46+Z1vmErULkCSf1P
         +EXJLWBJv2jCvz3yyAHguIBXQMJFWeYM86oJaR6+oTeM7YcDp1pqfEon7Hivhqz7Zikl
         xz6W9DC6migJJ6B+2jfhSckIzQG3x3k9kT7NT3Jtz6PGQ/qfmNXNeZhgSwklik3NJqL7
         gGBGLImvLMVp5phFOedvPI6uGqMNw7JWr07iTG8zTE0B6H7HfwRg2ZhCew42owLIKlPl
         TeZA==
X-Gm-Message-State: APjAAAWjspp5mtC9X0uE3yknjXNJhOOKdEUEyQ2vCRC29M7cXTsGO+R3
	igCwssXk5NapHENRzgSR7xSRvunVuXZ9T1t+U9dvwA==
X-Google-Smtp-Source: APXvYqw0R8WcBTJ+WQckxwd2QbhKiOtTnFs0z4BzcCMRmclhqiudO7gP8j2I8Si9NG3BnOx9PmVKuodRR9xJBbE+kh4=
X-Received: by 2002:a9d:7843:: with SMTP id c3mr8256796otm.71.1571424227725;
 Fri, 18 Oct 2019 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-2-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-2-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 11:43:36 -0700
Message-ID: <CAPcyv4j0-fkCu-8fR254yK7caw1Sv+YZe+LXP9v=TYpGKXwECQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 01/10] libdaxctl: refactor path construction in op_for_one_memblock()
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: CDULU3CMJKKH4JYQOLTKZOFSTL5DYYZY
X-Message-ID-Hash: CDULU3CMJKKH4JYQOLTKZOFSTL5DYYZY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CDULU3CMJKKH4JYQOLTKZOFSTL5DYYZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> In preparation for memblock operations to check additional sysfs
> attributes in the memoryXXX block, 'path' can't be prematurely set
> to the memoryXXX/state file.
>
> Push down path construction into each memory op helper, so that each
> helper gets an opportunity to reconstruct and act upon multiple paths.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Makes sense:

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
