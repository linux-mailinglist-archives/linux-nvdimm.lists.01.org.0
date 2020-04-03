Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F004419CDFF
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 02:59:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B813F101078EE;
	Thu,  2 Apr 2020 17:59:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2F7C2101078EC
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 17:59:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e5so7098560edq.5
        for <linux-nvdimm@lists.01.org>; Thu, 02 Apr 2020 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQQqVVbzAcBVOhSvw4EuxUsJxoKXOFCUVak73SIYWAw=;
        b=LiiHwVUIudIQW4lkFokCYO2kTjTv3HTk/jG+DF4Lu+b1ZWYKETmLRQI1UZRaDqSAgT
         dAofu33P+B/Rn7x7BnCESHpgvkvt0FOet/CKqV0JRoc4o3Eg16l1ZHPh8/ZRb8/axGYn
         wm4yC1KpZ/etMgAsxRBXcxLAVSauNm61v0Cpf/abrt2oDxR5dkv87Dsgq9mYXBU7CndG
         atq7tikbCpESsGHm10Kn4POEAGgh5kZGB/ZgczOoxM8JOdlhsl+4ZHV6cwfPQWN7nhBU
         DbQSPEqTWpDx+rAoqrMT68lIAfl+tjVi1RVFTogH5IUrXl2masLAQQsSxotnRQOShc6M
         ovIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQQqVVbzAcBVOhSvw4EuxUsJxoKXOFCUVak73SIYWAw=;
        b=tP7GR2Mp7h32zogemlQ+rzh9Ybpx+uaEPel7Qb8YnQ6+PW4MLrOqNoyW3ORXAQHnbB
         DqqVjxgXDIsU6Pb8K+tTEkYyuAVVF0P4W04p7EJGqB5H8OvwDr9FN0YgUjXEq4qvggth
         hKWpBKlkEJfiG5b3M8yiqdC/0xVijwL9qyWfFkPai4bmb0I9wnGVmB7EddwhDWd16XkI
         04IbTfkDCNW7YYHtHodcN/rrA7Jpm1X4Yp4IKbasYJukZAAgX1t1Rjzg8LfXPjd6kh3N
         TBdKo1n9uQFvuvaGH+cXQvV4ciGcF2AfxTq5VwzwkUEDmzvbjcJJRppUF6O8J646q8Vx
         5aDQ==
X-Gm-Message-State: AGi0PuaJa9LluQcl76VknCPP6y4q1cZuVz7JyIHn/dr3hkDuKWAZLgGX
	oXLZ6v4s02HrhAXg6qzx5yvZairC/Bl5Zd9MrAU67Q==
X-Google-Smtp-Source: APiQypL0cHlfxDZy3upCWoUKh1OZxIVT/GJBhlQfZAkj46oP9jfLm5k6lN7cCtMjaXB1N7V0H1xb1ZKYeojomT01PWs=
X-Received: by 2002:a50:d847:: with SMTP id v7mr5475185edj.154.1585875540967;
 Thu, 02 Apr 2020 17:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200331143229.306718-1-vaibhav@linux.ibm.com>
 <20200331143229.306718-2-vaibhav@linux.ibm.com> <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
In-Reply-To: <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Apr 2020 17:58:50 -0700
Message-ID: <CAPcyv4ipo0q-d+N=Bsp1+Mo2QBhT=Q21pGvy20D=Gx95py3tzw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] powerpc/papr_scm: Fetch nvdimm health information
 from PHYP
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: 7YKEOBBNQBEFACAADK63Q4ONSEL66T43
X-Message-ID-Hash: 7YKEOBBNQBEFACAADK63Q4ONSEL66T43
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7YKEOBBNQBEFACAADK63Q4ONSEL66T43/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 1, 2020 at 8:08 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> >  * "locked"     : Indicating that nvdimm contents cant be modified
> >                    until next power cycle.
>
> There is the generic NDD_LOCKED flag, can you use that? ...and in
> general I wonder if we should try to unify all the common papr_scm and
> nfit health flags in a generic location. It will already be the case
> the ndctl needs to look somewhere papr specific for this data maybe it
> all should have been generic from the beginning.

The more I think about this more I think this would be a good time to
introduce a common "health/" attribute group under the generic nmemX
sysfs, and then have one flag per-file / attribute. Not only does that
match the recommended sysfs ABI better, but it allows ndctl to
enumerate which flags are supported in addition to their state.

> In any event, can you also add this content to a new
> Documentation/ABI/testing/sysfs-bus-papr? See sysfs-bus-nfit for
> comparison.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
