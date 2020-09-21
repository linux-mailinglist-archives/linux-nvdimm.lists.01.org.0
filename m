Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0BF2732F1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 21:36:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3F6414E003C8;
	Mon, 21 Sep 2020 12:36:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com; envelope-from=griestmariec@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C34314545402
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 12:36:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u21so12099658ljl.6
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tdFbRdjHkOzBBbcHSrt56bviqdlUyhbooIJDpMAY4y8=;
        b=NTM/FJ5l8asBc42QWTh7o98QdXG9zDvzg1zq1XFnXxcvBah/xy4n7oiCadkc+7+T1g
         D7cujZeVWdeKE1gRpEbE05kbRrIJ4D0wWZRJgtFifJbqtpAlDV+GzaTpGrDTsQ19wJE6
         wb3hgW78ZByPHeMf4nEteqj4wV5dsbcc5iDvalLBfT3b8nhABQzF54NZRrU0kLTnniTJ
         LWjLxafZGryCnR8VoMuv65wnm6CuPXVF8hxq2N+EFr7zS7wM24kFYdL00HZBgknQLINS
         IfXkl6SX95B0ukxdIR76qjaYZ7E6AcCGxThTp53+4+RHQzUTmuMW8ytOu06fMqjk3+vK
         8v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tdFbRdjHkOzBBbcHSrt56bviqdlUyhbooIJDpMAY4y8=;
        b=tWjfvOZ5utIRlsTivhpep8eiRrXDT3zobAU24YRJnJLKHZxs2vgjWwXKEASZEYR0Md
         RhHk5oIkbtvbYyFRyNBvMGYNSSdBB31zBCPJOpNQWLQQJWYuigxI8Io3oE6dMQ5bDi9S
         wEm+30jk3lYbXwDV7ERgSbSZvwtEx1dsK6rjO5QTsdYyvAMIGaGELe+84xtEPht9mXX5
         20MrPb10By8nu7R3DlIbgOX0pgne4ZwZUDKmDJG1EpcqWas2YnnYR1C6xgrjlkaHqUXj
         hkJU1n5vRTGQI2+3xxPpQs2pIV5zA5Ns9d177ogGTr+av8xo9JaN0y9lrZUxx1ajC6d6
         XQtw==
X-Gm-Message-State: AOAM53236tFP2Dk+FYepbXG3vcNehuIb9W2JKTDtPwn7fXhphIy/feLt
	gmJt4yprvL2zi/YIWUSQdoMHWJQayx4Fmh3yrzE=
X-Google-Smtp-Source: ABdhPJyYpWYApFlmTZaKo9DxtJ1SXGjTfSkWvo6a7ulw0OWd9wECDhSgJbI4YJmPfg/08u1Jw2frjsflJFaba0C6zK8=
X-Received: by 2002:a2e:2e13:: with SMTP id u19mr357277lju.11.1600716987386;
 Mon, 21 Sep 2020 12:36:27 -0700 (PDT)
MIME-Version: 1.0
From: griest marie <griestm266@gmail.com>
Date: Mon, 21 Sep 2020 19:36:16 +0000
Message-ID: <CADbT_x681Q0HgdS8zcKEMPR1H=iVTGXEZgvvWesv-YSp3TJbmg@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: W5RUXQVRAHOG5AEISELFKQCVGNDK4BWG
X-Message-ID-Hash: W5RUXQVRAHOG5AEISELFKQCVGNDK4BWG
X-MailFrom: griestmariec@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W5RUXQVRAHOG5AEISELFKQCVGNDK4BWG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

HELLO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
