Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE31CBBBD
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 02:18:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1F0A1189A235;
	Fri,  8 May 2020 17:16:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=graceoootapia@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE4F41189A235
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 17:16:09 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i16so3060362ils.12
        for <linux-nvdimm@lists.01.org>; Fri, 08 May 2020 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=TCmtOMV6B4GoHb6SujRCiF7xpYgM1D3vlk+ZOITZb3k=;
        b=TlgouCxyfvpbItPZ8gcCxSKDqaZKbGXnP2SV4bd3T2dqI/yQ22v3OA9nYX9MxBba5R
         CVpuJCJmzOViWFUQk7b251nr8SxFAEJ5s2vKbpwSaGWzNiuP5j+DZEsCG4H+Ax2n50hn
         ra22m7vgMKNAD9FD1UGCWlvlm1pyI+sPfYJ62FpCRS8KfaTTt+gVWcEzGUwvJutCEYjo
         X9jBQqx2j2UbzFnI58goV0dFpcLkbLisBqWH4mkduYL5VA43AvNWFVvexN5fkF0heENd
         c35G61o1ihfRoSAzlomhZd1SXSm/MzpiUIhSHA8i5G4fMXGJesQD7UfjvsO16AqaSEvJ
         9Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=TCmtOMV6B4GoHb6SujRCiF7xpYgM1D3vlk+ZOITZb3k=;
        b=jC46n4W41f0DAVEm7sxfdxSNCq4463FC0bblgFaZAi2cIAIDOBhbQZ6Q+l4adrpmVI
         LTSOngzxIf2NIs2QllyTEz99yQB9aWRAF3FP5ao2Qxt0LOMoOWgZYoPQKYr8xvA9Ag9W
         FHeuP2+FOnGmj6nHgVPGgd8EnGBhv4wtMSv/UgdB09KaQZJDIqXV8nTDHC78Kqd+iT4Z
         S7Bqe8gJbdOJocXkVUlqyvYj3u3sAaFE7pZH1gk6XiK68DSznLgtxxASgFd0cwb9EXrX
         DqcT4u9wgLHd8nplFgpjxncSVKyWqyz34MYf2Xn5wl5A359dGBELQ6eWWNJwK/LFSXJF
         J0tw==
X-Gm-Message-State: AGi0PuapQlc1vf03SDKJlkeLDSsZuXW+hbfYuWxEDzEGGoe07sMDB8xz
	UvMj4xW40t/nlCyBqKO7MT41+zikBc2b231XZSo=
X-Google-Smtp-Source: APiQypLGA6QexZWhzFNOb5DUpYooBhdDDvyBxdjHHA/vwHPYxwf5xGyk4+sp33OC1ZyvunPxHomp+jWYK2klh3Z2dnY=
X-Received: by 2002:a92:858b:: with SMTP id f133mr5064892ilh.97.1588983495723;
 Fri, 08 May 2020 17:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:48:0:0:0:0 with HTTP; Fri, 8 May 2020 17:18:14
 -0700 (PDT)
From: Mr Francois Stamm <graceoootapia@gmail.com>
Date: Fri, 8 May 2020 17:18:14 -0700
Message-ID: <CALwc=dR2DUewCxh=GGx4LFGLSS+NKDWNUhUrdi_uYCaBWDJd3w@mail.gmail.com>
Subject: Charity Work
To: undisclosed-recipients:;
Message-ID-Hash: O7R5GQT74N4DFXOQC5P7MTBFNHYUQ66Y
X-Message-ID-Hash: O7R5GQT74N4DFXOQC5P7MTBFNHYUQ66Y
X-MailFrom: graceoootapia@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: fjstamm25@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O7R5GQT74N4DFXOQC5P7MTBFNHYUQ66Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ,

I m Mr. Francois Jean Stamm from Switzerland i am the chief delegate
south Sudan based ICRC Chief , my objective to send this mail across
to you  on mere internet search of a friend from your Country, I lost
his contact ,internet pump up your email is  to extend our
humanitarian aid/assistance to  your country  on behalf of my
organization INTERNATIONAL COMMITTEE OF THE  RED CROSS
ORGANIZATION(ICRC) is an None governmental organization (NGO) in
Conjunction with  THE UNITED NATION is a
journal of a humanitarian assistance such  as: Transgression of Human
Rights in Humanitarian Emergencies, Providing Jobs including
hospitality , youth and women empowerment of Agriculture : The Case of
 Somali Refugees in Kenya and Zimbabwean Asylum-Seekers in South
Africa  Mapping Population Mobility in a  Remote Context: Health
Service Planning  in the Whatnot District, Western Ethiopia,
Humanitarian Challenges and Dilemmas in Crisis Settings.

Our objective is to reach the need and the less privileged globally
through  this project, we unanimously agreed to extend our charity
work to your  country as benefactor to this assistant project.

We need a sizable undisputed land in a good area where we can
establish an  orphanage home to effect life of the less
privileged/orphans. On behalf of my organization International
committee of the red cross  organization(ICRC) I advised you urgent
search of land at any cost as to  enable the organization to exhibit
action, furthermore the effective  execution of this proposed project
will be under your supervision .

Best Regards

Francois.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
